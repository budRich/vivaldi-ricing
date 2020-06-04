## the ultimate reddit rice

I don't have a reddit account, I think the modern design is slow and bloated and I have a little too much time to waste, this is my reddit rice.  

![](/img/scrotcomp.png)  

I have tried to make it as modular as possible and separated each *feature* into its own **user.css (_userstyle_)** or **user.js (_userscript_)**. The subdirectories here contain the files and maybe a screenshot, maybe.  

If you have [stylus] and [violentmonkey] installed you can install the files by clicking the links in the table below:  

[stylus]: https://add0n.com/stylus.html
[violentmonkey]: https://violentmonkey.github.io/

| file | function |
|:-----|:---------|
[reddit-theme.user.css] | applies better colors, which are applied from a set of custom properties (*CSS variables*), so they can easily be changed. |
[reddit-sidebar.user.css] | Hides the sidebar by default and adds a button to toggle it + some aesthetic improvements. |
[reddit-no-bloat.user.css] | hides ad and "promoted" elements |
[reddit-no-account.user.css] | Hides elements that are of no use without a reddit account |
[reddit-dirthack.user.css] | aesthetic fixes that works with, expando-swap.user.js |

[reddit-dirthack.user.css]: https://github.com/budRich/vivaldi-ricing/raw/master/reddit/reddit-dirthack.user.css
[reddit-no-account.user.css]: https://github.com/budRich/vivaldi-ricing/raw/master/reddit/reddit-no-account.user.css
[reddit-no-bloat.user.css]: https://github.com/budRich/vivaldi-ricing/raw/master/reddit/reddit-no-bloat.user.css
[reddit-sidebar.user.css]: https://github.com/budRich/vivaldi-ricing/raw/master/reddit/reddit-sidebar.user.css
[reddit-theme.user.css]: https://github.com/budRich/vivaldi-ricing/raw/master/reddit/reddit-theme.user.css

## but first, return to the past

For this rice to work ~~correctly~~, one must first make sure that reddit is displayed in it's ~~good~~ old way, and disable any subreddit specific userstyles.  

I use the extension [Redirector](http://einaregilsson.com/redirector/) to redirect any URL to *modern* reddit to `old.reddit`.  

![](/img/redirector.png) 

`https://(www[.])?reddit[.]com(.*)`


[reddit toggle custom css] is a user script that lets you toggle between the default CSS and subreddit specific CSS from the (grease|tamper|violent)-monkey menu. (selection is remembered across sessions). 
However the default is to show subreddit specific css, 
but that can be inversed by changing the line:  
`const DISABLE_CSS = false`  
to  
`const DISABLE_CSS = true`  


[reddit old school]: https://greasyfork.org/en/scripts/381544-reddit-old-school/code
[reddit toggle custom css]: https://greasyfork.org/en/scripts/23434-reddit-toggle-custom-css/code

