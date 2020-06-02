This directory contains overrides for Vivaldis UI elements.
All UI is done with HTML, javascript and CSS.
The UI can be *inspected* like any other webpage (right click an element, f.i. the address bar and select **Inspect**) 
if vivaldi is started with the following commandline options:  
`--debug-packed-apps --silent-debugger-extension-api`  

[vivaldi-launch.sh] will start the browser with the options enabled.

---

### CSS

to override the CSS for the UI in Vivaldi, one must:

enable the feature on [vivaldi://experiments](vivaldi://experiments)  
![](experiments.png)  

set the directory where the css files are stored in **settings->Appearance->Custom UI Modifications** (*it's easiest to just search for `custom ui`*)  

![](cssdir.png)

Vivaldi will apply all styles in all CSS files in the selected folder when the browser is launched. It is really easy to maintain styles, but one needs to restart the browser for any changes or new styles to apply. In the [css](https://github.com/budRich/vivaldi-ricing/tree/master/vivaldiUI/css) directory are some styles.

### JS

Javascript overrides are a bit more complicated to apply. 
All the UI source files that Vivaldi uses are located (on arch linux) at:  
`/opt/vivaldi/resources/vivaldi/`  
To add your own javascript files, 
add them to that directory and link them in `browser.html` in the same directory.
javascript overrides are not fully supported and there are several drawbacks one needs to beaware of:
- When Vivaldi is updated it will overwrite the `browser.html` file.
- Changes done in this directory are systemwide and will affect all users and profiles in vivaldi.
- the directory is owned by **root** so you need sudo privileges to make changes.

To simplify the process of adding and updating (this needs to be done on every update of the browser) there is a script in the [js](/js/) directory called [vivaldi-add-js.sh](/vivaldiUI/js/vivaldi-add-js.sh). When the script is executed it will add all `.js` files in the same directory as the script. 

# Known Issues
if you apply [ext-in-status.js](/js/ext-in-status.js) be aware that fullscreen functionality will stop working. A workaround is to use **picture-in-picture** mode and fullscreen the external player (imo this works better then the default fullscreen).  

```
*todo*  
see if it's possible to setup a hook for pacman and run automatically ru the script on every update.
```


[vivaldi-launch.sh]: https://github.com/budRich/vivaldi-ricing/blob/master/vivaldi-launch.sh
