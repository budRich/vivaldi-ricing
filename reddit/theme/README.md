## reddit theme - colors

The theme and colorscheme is derived from:  
https://github.com/itsamoreh/reddit-no-frills

This **userstyle** more or less only changes the colors (and some corner radius and borders) of the default old reddit feed. So for this to work one must first make sure that reddit is displayed in it's *good* old way, and disable any subreddit specific userstyles.  

The *easiest* way to achieve that is to install these two **userscripts**:  

userscripts:
[reddit old school] - this will redirect any visits to nu-reddit to old.reddit.com, and includes a couple of enhancements (page will scroll to the latest expanded item, and such). It *just werks™*.  

[reddit toggle custom css] lets you toggle between the default css and subreddit specific css from the (grease|tamper|violent)-monkey menu. (selection is remebered across sessions). 
However the default is to show subreddit specific css, 
but the can be inversed by changing the line:  
`const DISABLE_CSS = false`  
to  
`const DISABLE_CSS = true`  


[reddit old school]: https://greasyfork.org/en/scripts/381544-reddit-old-school/code
[reddit toggle custom css]: https://greasyfork.org/en/scripts/23434-reddit-toggle-custom-css/code

