module Localeapp
  class ExceptionHandler
    def self.call(exception, locale, key_or_keys, options)
      keys = Array(key_or_keys).map { |key| ERB::Util.html_escape(key.to_s) }
      Localeapp.log(exception.message)
      # Which exact exception is set up by our i18n shims
      if exception.is_a? Localeapp::I18nMissingTranslationException
        Localeapp.log("Detected missing translation for key(s) #{keys.inspect}")

        keys.each do |key|
          Localeapp.missing_translations.add(locale, key, nil, options || {})
        end

        [locale, keys].join('.')
      else
        Localeapp.log('Raising exception')
        raise
      end
    end
  end
end

I18n.exception_handler = Localeapp::ExceptionHandler
