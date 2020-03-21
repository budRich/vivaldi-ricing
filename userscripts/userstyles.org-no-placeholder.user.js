// ==UserScript==
// @name        userstyles no placeholder ad
// @namespace   budlabs
// @grant       none
// @include     https://userstyles.org/*
// @version     1.0
// @author      budRich
// @description hides ads style in style entry list
// ==/UserScript==


function hide_ads() {
    let container = document.getElementsByClassName("us-stylecards__container")[0]
  
    if (container){
      let cardclass = (
      container.classList.contains("us-stylecards__container--stylecard-short")
      ? "us-stylecard--short" : "us-stylecard--long")

      let cards = document.getElementsByClassName(cardclass)

      for (let card of cards) {
        if(card.querySelector(".fallbackDiv"))
        {
            card.style.display = "none"
        }
      }
    
        
    }
}

hide_ads()
// rerun the code each time document change
// for example when toggling between viewmodes
document.addEventListener("DOMNodeInserted", hide_ads)
