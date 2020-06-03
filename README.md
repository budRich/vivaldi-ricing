## this is my Vivaldi rice

![](/img/splitbig.png)

Vivaldi is a very *rice friendly* browser and much of the my rice can be achieved from the normal settings, but i also have a bunch of custom scripts and hacks here to achieve the browser experience i want.

### optimized for use with a tiling window manager

[vivaldi-launch.sh] is the script I use to launch/activate the browser. It uses **xdotool(1)** (or [i3run] if it is installed) to rename the class of the *main window*. The reason I want to do this is that I can easily apply window rules and keybindings from my window manager. I use [i3wm] and by having one window rule for the main window and another rule for vivaldi windows without a custom class (`Vivaldi-stable`) i get a better tiled experience.  

In the screenshot above the main vivaldi window is to the left and I have just opened the settings window (<key>Ctrl</key>+<key>F12</key>).
The setting window will have the default window class set by Vivaldi, `Vivaldi-stable` and it is automatically placed in the lower right container (**D**), and this is true for any *extra* window that would get created, f.i. **devtools** or **stylish style editor**. Here I also play a video using the **picture in picture** functionality, and that window also have a rule and will always get placed in the upper right corner (**B**).

So after making symlink of [vialdi-launch.sh] to my **PATH**  
`ln -fs $PWD/vivaldi-launch.sh ~/bin/vivaldi-launch` and having [i3fyra] installed.
All I need in my i3 config (`~/.config/i3/config`) are the following lines:  

```
bindsym Mod4+f exec --no-startup-id vivaldi-launch

for_window [class=Vivaldi-stable] exec --no-startup-id i3fyra --move D
for_window [class=Vivaldi-main]   exec --no-startup-id i3fyra --move C
for_window [title="Picture in picture"] focus, exec --no-startup-id i3fyra --move B
```

### keyboard centric

As you can see in the screenshot, i don't have a address bar. I have moved all the stuff i want from the adressbar to the statusbar, this is achieved by some CSS and JS overrides which can be found in the [vivaldiUI directory](./vivaldiUI). I use [vb4c] (*VIM bindings for chrome*), an extension that adds a ton of commands that can be fired with single-key hotkeys in a similar way to how VIMs *normal mode* works. As an example i can press <key>o</key> (`:open` command) which will pop up the **vb4c** status bar where i can open a new url. This is much more powerful, convenient and minimal then using the regular built in address bar.  

### executing external system commands

One *feature* in [vb4c] is that it supports opening a text box as a temporary file in an external texteditor (VIM, sublime, whaterver). I poked around in the code a bit and found a way to exploit this feature to support the ability to pass URLs (that can be selected with hints) to any external command. I have a custom URL handler, [gurl], that I use together with this function all the time. But to make it work one must run a local python webserver and have both the server and the configuration file for [vb4c] setup with correct port numbers etc. This is another thing that [vivaldi-launch.sh] does, whenever the script is executed it will test the connection to the webserver and if it is not running it will start it.


[i3wm]: https://i3wm.org
[i3run]: https://github.com/budlabs/i3ass/wiki/17AS_i3run
[i3fyra]: https://github.com/budlabs/i3ass/wiki/11AS_i3fyra
[vb4c]: https://github.com/dcchambers/vb4c
[vivaldi-launch.sh]: ./vivaldi-launch.sh
[gurl]: https://github.com/budlabs/gurl

[stylus]: https://github.com/openstyles/stylus
[violentmonkey]: https://violentmonkey.github.io/
[Redirector]: http://einaregilsson.com/redirector/
