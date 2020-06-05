![](/img/scrot.png)

This is how I like my vivaldi, I merge all *important* elements from the addressbar in to the statusbar and then hide the addressbar (i get the actual address functionality with [vb4c](../vb4c)).

I also have **settings->Appearance->User Interface Zoom** set to `80%` to get a even more space for actual content.

![](/img/uisettings.png)

All UI is done with HTML, javascript and CSS.
The UI can be *inspected* like any other webpage (right click an element, f.i. the address bar and select **Inspect**) 
if vivaldi is started with the following commandline options:  
`--debug-packed-apps --silent-debugger-extension-api`  

[vivaldi-launch.sh](../vivaldi-launch.sh) will start the browser with the options enabled.

---

### CSS

to override the CSS for the UI in Vivaldi, one must:

enable the feature on [vivaldi://experiments](vivaldi://experiments)  
![](/img/experiments.png)  

set the directory where the css files are stored in **settings->Appearance->Custom UI Modifications** (*it's easiest to just search for `custom ui`*)  

![](/img/cssdir.png)

Vivaldi will apply all styles in all CSS files in the selected folder when the browser is launched. It is really easy to maintain styles, but one needs to restart the browser for any changes or new styles to apply. In the [css](./css) directory are some styles.

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

To simplify the process of adding and updating (this needs to be done on every update of the browser) there is a script in the [js](./js/) directory called [vivaldi-add-js.sh](./js/vivaldi-add-js.sh). When the script is executed it will add all `.js` files in the same directory as the script. 

--
## [ext-in-status.js](./js/ext-in-status.js)

This mod will move the extension buttons into the statusbar. 
It will also move the "add bookmark" and "reader mode" buttons from the address bar to the statusbar. It is based on a [script by **luetage** that i found in the modification section of the vivaldi forums](https://forum.vivaldi.net/topic/20643/showing-extension-icons-on-the-bottom-of-the-browser/43?lang=en-US&page=3).

Many of the style overrides in the [css](./css) directory are necessary for this not looking to broken.

## Known Issues
if you apply [ext-in-status.js](./js/ext-in-status.js) be aware that fullscreen functionality will stop working. A workaround is to use **picture-in-picture** mode and fullscreen the external player (imo this works better then the default fullscreen).  

It is also important that the addressbar and the statusbar both are located at the top or both at the bottom before applying this mod, otherwise the popups that appeares when an extensionbutton is clicked will not be visible.

```
*todo*  
see if it's possible to setup a hook for pacman and run automatically ru the script on every update.
```
