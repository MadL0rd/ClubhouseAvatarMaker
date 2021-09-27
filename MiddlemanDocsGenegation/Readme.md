# Middleman docs genegation

This folder needs to generate documetation static websites and use it with [Github Pages](https://pages.github.com/)

Main advantage is that you can write all text using only markdown 

## Installation

You need to install [Middleman static site generator](https://middlemanapp.com/) so you can follow this [instruction](https://middlemanapp.com/basics/install/) or run this commands in your terminal

``` bash
xcode-select --install
gem install middleman
```
## Configuration
Open folder gem install middleman ```MiddlemanDocsGenegation``` 
In file ```./data/site.json``` you can change variables if it needs

If you want to customize color theme of this template open ```./source/stylesheets/site.css.scss``` and modify style wariables

If you want to create own template configuration check the [Middleman documentation](https://middlemanapp.com/basics/install/)

## Documents generation

Open up your terminal and run this commands from ```MiddlemanDocsGenegation``` folder
``` bash
sh GenerateDocs.sh
```
Next commit all changes and go to project repository settings. Click on the ```Pages``` menu link and choose ```master``` branch and ```/docs``` folder then click save button

	🎉  Congradulations! 🎉
    Documents was successfully generated and hosted on Github Pages!

So you can connect your own domain and noone will know that your documentation hosed on Github Pages

## Bonus
If you need simple API for your project you can use this way to return content for example in json format. Template contains one test file ```test.json```
