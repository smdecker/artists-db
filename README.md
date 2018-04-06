# artists-db
Sinatra application for artists materials and artworks. Users can upload their artworks/materials to the database and group them by category. Each artwork and material can also be associated with each other and viewed as a 'related' item.

## Installation

clone repository and execute:
`bundle install`

run migrations:
`rake db:migrate`

run shotgun:
`shotgun`

open designated localhost and create an account to get started

## Notice
This repository does not contain an environment.rb file as it contains Amazon web services access keys. If you would like to use this application with an image uploader please see these guidelines to implement the CarrierWave gem with Sinatra: https://www.softcover.io/read/27309ccd/sinatra_cookbook/gallery

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/smdecker/artists-db.

This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the <a href="https://www.contributor-covenant.org/">Contributor Covenant</a> code of conduct.