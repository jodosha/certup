# CertUP :up:

Command line tool (CLI) to upload SSL certificates stored in [DNSimple](https://dnsimple.com) to [Netifly](https://netlify.com).

## Installation

```shell
$ git clone https://github.com/jodosha/certup.git && cd $_
$ cp .env.example .env
$ bundle
```

Generate DNSimple **account token** and Netifly token and add them to `.env`.

## Usage

```shell
bin/certup my.website.org
```

## Copyright

&copy; 2018 - Luca Guidi https://lucaguidi.com
