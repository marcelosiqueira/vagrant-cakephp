# Vagrant Chef for CakePHP

Vagrant Chef creates a Vagrant installation for CakePHP using Chef with the following features:

- Ubuntu 12.04 Precise Pangolin
- Ningx 1.4
- PHP 5.5
- Percona MySQL 5.5
- Memcached 1.4
- Git 1.7
- Composer
- CakePHP 2.4.4
- phpMyAdmin

## Requirements

- [VirtualBox](https://www.virtualbox.org/wiki/Downloads). Tested on 4.3.x, but 4.2.x should also work.
- [Vagrant](http://www.vagrantup.com/downloads.html). Tested on 1.4.3

## Installation

Download and install both VirtualBox and Vagrant for your particular operating system. Should only take a few minutes on a DSL connection

Once those are downloaded, open up a terminal. We'll need to clone this repository and setup vagrant:

    cd ~/Sites
    git clone git@github.com:marcelosiqueira/vagrant-cakephp.git
    cd vagrant-cakephp

Now we need to setup the vagrant installation. This is pretty easy:

    cd ~/Sites/vagrant-cakephp
    vagrant up

It may take a bit to download the Vagrant box, but once that is done, you will be prompted for your laptop password. This is so we can properly expose the IP of the vagrant instance to your machine. Type in your password and let it continue running.

You can grab a coffee or go out for a beer at this point. Takes about half an hour to an hour, depending upon your internet connection and laptop resources.

Of note is that typing `vagrant ssh` while your vagrant instance is up will ssh onto the instance so you can perform commands directly on it. For example, it might be useful to manually install some service, or run a script within the repository.

Once it is done, browse to `http://192.168.13.2/` in your browser, and you should have some sort of `It works!` page! At this point you can set your virtualhosts to point at the instance for maximum win.

#### Custom Domain Name

If you want to access the site using a custom domain name, edit your `/etc/hosts` file to have the following line:

    192.168.13.2 www.app.dev app.dev

#### Developing your application

When you want to use vagrant instance for a development environment, you can replace the `app` directory with the contents of your application. Within the vm, this would be an example of your directory structure:

    |-/vagrant/app
    | |-/vagrant/app/Config
    | |-/vagrant/app/Console
    | |-/vagrant/app/Controller
    | |-/vagrant/app/Lib
    | |-/vagrant/app/Model
    | |-/vagrant/app/Plugin
    | |-/vagrant/app/tmp
    | |-/vagrant/app/vendor
    | |-/vagrant/app/View
    | |-/vagrant/app/webroot


Anything in `app/webroot/index.php` will be served up, and all other `index.php` files ignored.

## Starting/Stopping Work

You normally wont want to have the instance running full time. To pause it, simply perform the following in the command line:

    cd ~/Sites/vagrant-cakephp
    vagrant suspend

You will no longer be able to access the instance after doing this. To continue working, issue the following commands:

    cd ~/Sites/vagrant-cakephp
    vagrant resume

## Updating Vagrant

Running `vagrant provision` will reprovision the instance. You won't normally need to do the things in the **Installation** section, but this will ensure your setup is as up-to-date as possible.

If there are any updates to the vagrant setup, such as a new feature, new site hosted within, or new service, simply do the following in a terminal:

    cd ~/Sites/vagrant-cakephp
    git pull origin master
    vagrant provision

## Starting fresh

We're sad to see you leave your work behind, but getting a fressh start isn't hard. Simply do the following:

    cd ~/Sites/vagrant-cakephp
    vagrant destroy
    cd ..
    rm -rf vagrant-cakephp

This will destroy your vagrant installation and remove all traces of it from your laptop.

## Bugs?

File a github issue.

## Fork

https://github.com/FriendsOfCake/vagrant-chef
Jose Diaz-Gonzalez

## MIT

Copyright (c) 2012 Marcelo Siqueira

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
