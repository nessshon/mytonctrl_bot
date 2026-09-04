import time
import urllib.parse
import urllib.request

STALE_AFTER = 120


class Heartbeat(object):
	def __init__(self):
		self.last_ok = None
		self.last_error = None
		self.url = None
		self.gatus_token = None
	#end define

	def install(self, bot, url, gatus_token, bot_token):
		self.url = url
		self.gatus_token = gatus_token
		get_updates = bot.get_updates
		def wrapped_get_updates(*args, **kwargs):
			try:
				result = get_updates(*args, **kwargs)
			except Exception as e:
				self.last_error = f"{type(e).__name__}: {e}".replace(bot_token, "***")[:200]
				raise
			self.last_ok = time.monotonic()
			self.last_error = None
			return result
		#end define
		bot.get_updates = wrapped_get_updates
	#end define

	def tick(self):
		if self.last_ok is None and self.last_error is None:
			return  # first poll hasn't happened yet — don't report anything
		if self.last_ok is not None and time.monotonic() - self.last_ok < STALE_AFTER:
			query = "success=true"
		else:
			reason = self.last_error or f"no successful getUpdates within {STALE_AFTER}s"
			query = "success=false&error=" + urllib.parse.quote(reason)
		req = urllib.request.Request(f"{self.url}?{query}", method="POST",
			headers={"Authorization": f"Bearer {self.gatus_token}"})
		try:
			urllib.request.urlopen(req, timeout=5).close()
		except Exception:
			pass
	#end define
#end class
