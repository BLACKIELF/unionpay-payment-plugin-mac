/**
 * OpenIE Bookmarklet / Console Script
 * 
 * Alternative workaround if you prefer not to install any application.
 * Paste this into browser console or save as bookmark URL.
 */
javascript:(function(){
  function convert(url) {
    if (typeof url === 'string' && url.toLowerCase().startsWith('openie:')) {
      return url.replace(/^openie:/i, '').replace(/^\/\/(?=https?:)/i, '').replace(/separator/g, '&');
    }
    return url;
  }

  var modified = 0;
  // Convert any <a> elements
  document.querySelectorAll('a').forEach(function(a) {
    if (a.href && a.href.toLowerCase().startsWith('openie:')) {
      a.href = convert(a.href);
      a.target = '_blank';
      modified++;
    }
  });

  // Intercept window.open
  var origOpen = window.open;
  window.open = function(url, target, features) {
    return origOpen.call(window, convert(url), target || '_blank', features);
  };

  alert('OpenIE Resolver: Successfully intercepted ' + modified + ' link(s). You can now proceed with payment.');
})();
