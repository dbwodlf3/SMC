from typing import TYPE_CHECKING
if TYPE_CHECKING:
	from Detector.Objects.Detector import Detector

class CriticalDetector:
	detector: 'Detector' = None
	@classmethod
	def init(cls, detector: 'Detector'):
		cls.detector = detector
	@classmethod
	def run(cls):
		pass