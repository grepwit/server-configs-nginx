# [Nginx Server Configs](https://github.com/h5bp/server-configs-nginx)

[![Build Status](https://img.shields.io/travis/h5bp/server-configs-nginx/master.svg)](https://travis-ci.org/h5bp/server-configs-nginx)

**Nginx Server Configs** is a collection of configuration snippets that can help
your server improve the web site's performance and security, while also
ensuring that resources are served with the correct content-type and are
accessible, if needed, even cross-domain.


## Getting Started

Using the Nginx server configs repo directly has a few required steps to be able to work.

* [Nginx Beginners Guide](https://nginx.org/en/docs/beginners_guide.html)
* [Nginx Request Processing](https://nginx.org/en/docs/http/request_processing.html)


### Check `nginx.conf` settings

The first thing to check is that the `nginx.conf` file contains appropriate values for
your specific install. 

Most specific variables are:
* `user`
* `error_log`
* `pid`
* `access_log`

### Nginx test and restart

* To verify Nginx config
  ```shell
  $ nginx -t 
  ```

* To verify Nginx config with a custom file
  ```shell
  $ nginx -t -c nginx.conf
  ```

* To reload Nginx and apply new config
  ```shell
  $ nginx reload 
  ```


### Basic structure

This repository has the following structure:

```
./
├── conf.d/
│   ├── default.conf
│	  └── templates/
├── h5bp/
│   ├── basic.conf
│   ├── location/
│   └── .../
├── mime.types
└── nginx.conf
```

* **`conf.d/`**

  This directory should contain all of the `server` definitions.
  
  Except if they are dot prefixed or non `.conf` extension, all files in this
  folder **are** loaded automatically.

  * **`templates` folder**

    Files in this folder contain a `server` template for secure and non-secure hosts.
    They are intended to be copied in the `conf.d` folder with all `example.com` 
    occurrences changed to the target host.

* **`h5bp/`**

  This directory contains config snippets (mixins) to be included as desired.
  
  There are two types of config files provided, individual config snippets and
  combined config files which provide convenient defaults.

  * **`basic.conf`**
  
    This file loads a small subset of the rules provided by this repository to add
    expires headers, allow cross domain fonts and protect system files from web
    access.
    The `basic.conf` file includes the rules which are recommended to always be
    defined.

  * **`location/`**
  
    Files in this folder contain one or more `location` directives. They are intended
    to be loaded in the `server` context (or, in a nested `location` block).


* **`mime.types`**

  The mime.types file is responsible for mapping file extensions to mime types.

* **`nginx.conf`**

  The main Nginx config file.


## Usage

### As a reference

To use as reference requires no special installation steps, download/checkout the
repository to a convenient location and adapt your existing Nginx configuration
incorporating the desired functionality from this repository.

### Directly

To use directly, replace the Nginx config directory with this repository. for example:

```shell
nginx stop
cd /etc
mv nginx nginx-previous
git clone https://github.com/grepwit/server-configs-nginx.git nginx
# install-specific edits
nginx start
```

### Manage sites

```bash
$ cd /etc/nginx/conf.d
```

* Creating a new site
  ```bash
  $ cp templates/example.com.conf .actual-hostname.conf
  $ sed -i 's/example.com/actual-hostname/g' .actual-hostname.conf
  ```

* Enabling a site
  ```bash
  $ mv .actual-hostname.conf actual-hostname.conf
  ```
	
* Disabling a site
  ```bash
  $ mv actual-hostname.conf .actual-hostname.conf
  ```

```bash
$ nginx reload
```
## ModSecurity

To compile ModSecurity support with nginx, follow [this guide](https://www.nginx.com/blog/compiling-and-installing-modsecurity-for-open-source-nginx/)
or use one of these [recipes](https://github.com/SpiderLabs/ModSecurity/wiki/Compilation-recipes-for-v3.x).

Afterward, download the latest OWASP Core Rule Set and enable ModSecurity with
`bash get-owasp-crs.sh`. This command can also be used to checkout to the
latest changes on the current branch.

To compile nginx with PageSpeed as well, follow the guide above until right
before the step to build nginx and then continue with the guide below. When
it becomes time to configure, add
`--add-module=your/path/to/ModSecurity-nginx`.


## PageSpeed Support

Compile nginx with PageSpeed support following [this guide](https://www.linode.com/docs/web-servers/nginx/build-nginx-with-pagespeed-from-source/).

While the guide may mention using their "recommended starting point" for
configuration, you can keep your current configuration by copying and pasting
the configure arguments from `nginx -V`.

This option might require more dependencies based on your current OS, but
makes integrating PageSpeed (and using the latest nginx) with any existing
`conf.d` configurations much easier.


## Support

 * Nginx v**1.8.0**+


## Contributing

Anyone is welcome to [contribute](.github/CONTRIBUTING.md),
however, if you decide to get involved, please take a moment to review
the [guidelines](.github/CONTRIBUTING.md):

* [Bug reports](.github/CONTRIBUTING.md#bugs)
* [Feature requests](.github/CONTRIBUTING.md#features)
* [Pull requests](.github/CONTRIBUTING.md#pull-requests)


## Acknowledgements

[Nginx Server Configs](https://github.com/h5bp/server-configs-nginx) is only possible thanks to all the awesome
[contributors](https://github.com/h5bp/server-configs-nginx/graphs/contributors)!


## License

The code is available under the [MIT license](LICENSE.txt).
