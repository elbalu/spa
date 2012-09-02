Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '367021960037106', 'e85b494eee9517d7eeb3fd3ce3cfd51b', :setup => true
  #provider :facebook, '226754337433632', 'eacf1c10be67306ffbfecddc626a2aa0'
end

