# EasyCfdi
This is a Gem for build a valid XML file for the Mexican requirements of Digital Invoicing.

All the instructions are in spanish because I assume that all the persons interested are located in Latin America.

El propósito de ésta libreria es el siguiente:
 * Generar la estructura XML a partir de los parámetros recibidos.
 * Generar la Cadena Original e integrar el Sello y el Certificado al XML.
 * Devolver un XML listo para enviar a cualquier PAC para su timbrado.   

## Atención: Proyecto en fase Alpha
Ésta Gema se encuentra en proceso de construcción, tanto el código como la documentación están incompletos y desastrosos. Por favor vuelva despues.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'easy_cfdi'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install easy_cfdi

## Usage

TODO: Write usage instructions here

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/easy_cfdi.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
