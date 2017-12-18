# Changelog

All notable changes to this project will be documented in this file.

For more information about changelogs, check
[Keep a Changelog](http://keepachangelog.com) and
[Vandamme](http://tech-angels.github.io/vandamme).

## 1.0.0.alpha4  - 2017/12/18

* [ENHANCEMENT] Set scope as variable for `Fb::Auth#url`

## 1.0.0.alpha3  - 2017/08/31

* [FEATURE] Add Fb::Auth#revoke

## 1.0.0.alpha2  - 2017/07/25

* [ENHANCEMENT] Set scope `'email,pages_show_list,read_insights'` for `Fb::Auth#url`

## 1.0.0.alpha1  - 2017/07/24

This library was originally intended to provide methods to authenticate but
has grown to include other methods to configure, get posts, insights etc.
Most of those methods have been extracted into separate libraries.

* [REMOVAL] Moved Fb::Page to fb-core gem (without insights)
* [REMOVAL] Moved Fb::User to fb-core gem
* [REMOVAL] Moved Fb::Configuration to fb-support gem

## 0.1.3  - 2017/07/20

* [BUGFIX] Fixed `require` statement not loading for some classes.
* [BUGFIX] Fixed typo (it's `client_secret`, not `client_id`)

## 0.1.2  - 2017/07/11

* [ENHANCEMENT] `Fb::Page#insights` now takes a hash of options on method call.

## 0.1.1  - 2017/07/06

* [FEATURE] Add `Fb::Page#insights`

## 0.1.0  - 2017/06/29

* [FEATURE] Add `Fb::Auth#url`
* [FEATURE] Add `Fb::Auth#access_token`
* [FEATURE] Add `Fb::User#pages`
* [FEATURE] Add `Fb::User#email`
* [FEATURE] Add `Fb::Error`
