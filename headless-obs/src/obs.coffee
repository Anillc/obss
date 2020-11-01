ffi = require 'ffi-napi'
ref = require 'ref-napi'

{ initQt } = ffi.Library './libiq.so',
  'initQt': ['void', []]

initQt()

#libObsPath = '/usr/lib/x86_64-linux-gnu/libobs.so.0'
libObsPath = '/usr/lib/libobs.so'

Struct = (require 'ref-struct-di') ref

profiler_name_store = Struct {}

obs_video_info = Struct
  graphics_module: 'string'
  fps_num: 'uint32'
  fps_den: 'uint32'
  base_width: 'uint32'
  base_height: 'uint32'
  output_width: 'uint32'
  output_height: 'uint32'
  output_format: 'int'
  adapter: 'uint32'
  gpu_conversion: 'int'
  colorspace: 'int'
  range: 'int'
  scale_type: 'int'

obs_audio_info = Struct
  samples_per_sec: 'uint32'
  speakers: 'int'

obs_module_t = Struct {}

obs = ffi.Library libObsPath,
  'obs_startup': ['int', ['string', 'string', ref.refType profiler_name_store]]
  'obs_reset_video': ['int', [ref.refType obs_video_info]]
  'obs_reset_audio': ['int', [ref.refType obs_video_info]]
  'obs_open_module': ['int', [
    ref.refType ref.refType obs_module_t
    'string'
    'string'
  ]]
  'obs_init_module': ['int', [ref.refType ref.refType obs_module_t]]

module.exports = { obs, obs_video_info, obs_audio_info } 
