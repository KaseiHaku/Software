// ==UserScript==
// @name New Userscript
// @namespace http://tampermonkey.net/
// @version 2024-04-17
// @description try to take over the world!
// @author You
// @match https?://*/*
// @icon data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==
// @grant none
// ==/UserScript==

(function() {
  'use strict';

  // Your code here...
  alert('tamper monkey');
  let tamperDiv = document.querySelector( '#gghtty' );
  if(!tamperDiv){
    tamperDiv = document.createElement( 'div');
    tamperDiv.style.minHeight ='300px';
    tamperDiv.id = 'gghtty';
    tamperDiv.style.fontsize ='16px';
    tamperDiv.style.padding='32px';
    tamperDiv.style.background = '#ffffff'; 
    tamperDiv.style.zIndex = 99999999;
    document.body.append(tamperDiv);
  }
  window.tamperDivCount = 0;
  window.gghtty = setInterval(() => {
    let join= document.body.innerHTML.match(/(https?|ftp):\/\/hls[-_\w.\/?=&#;]*/gi)
      .filter(item => item.includes('.m3u8')||item.includes('.mp4'))
      .join('<hr/>');
    tamperDiv.innerHTML= join;
    if(window.tamperDivCount>3){ 
      clearInterval(window.gghtty);
    }
    window.tamperDivCount++;
  }, 10000);
})();
