ref = require 'ref-napi'

{ obs, obs_video_info, obs_audio_info, obs_module_t } = require './obs'

if !obs.obs_startup "zh-CN", null, null
  console.error 'failed to start obs'

ovi = new obs_video_info()
oai = new obs_audio_info()

ovi.adapter = 0
ovi.graphics_module = "libobs-opengl"
ovi.output_format = 1
ovi.fps_num = 60
ovi.fps_den = 1
ovi.base_width = 1024
ovi.base_height = 768
ovi.output_width = 1024
ovi.output_height = 768

oai.samples_per_sec = 44100
oai.speakers = 1

obs.obs_reset_video ovi.ref()
obs.obs_reset_audio oai.ref()

modulePath = '/usr/lib/obs-plugins/'
dataPath = '/usr/share/obs/obs-plugins/'
modules = [
  "obs-ffmpeg"
#  "obs-x264"
  "rtmp-services"
#  "linux-alsa"
#  "linux-v4l2"
  "obs-outputs"
#  "text-freetype2"
#  "obs-browser"
#  "vlc-video"
]

for moduleName in modules
  modulePtr = new Buffer 4
  modulePtr.type = ref.types.uint32
  obs.obs_open_module modulePtr, "#{modulePath}#{moduleName}", "#{dataPath}#{moduleName}"
  module = new Buffer 4
  module.writeInt32BE modulePtr.deref(), 0
  console.log obs.obs_init_module module

obs.obs_post_load_modules()
