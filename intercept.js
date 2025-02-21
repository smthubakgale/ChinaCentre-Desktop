
function intercept(url)
{
   var ur = url;
   console.log(ur);

   if(ur.indexOf("https:") == -1 && ur.indexOf("http:") == -1)
   {
      ur = 'https://smthubakgale.github.io/ChinaCentre/' + ur; 
   }

   console.log(ur);

   return ur;
}

// Create a MutationObserver
const observer2 = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
        // Check if the added node is an img tag or contains an img tag
        if (mutation.addedNodes) {
            mutation.addedNodes.forEach((node) => 
            {
                if (node.nodeType === Node.ELEMENT_NODE && node.nodeName === 'IMG') 
                {
                    console.log('Img tag added:', node);
                     
                }  
                else if (node.nodeType === Node.ELEMENT_NODE) 
                {
                    if (node.querySelectorAll('img').length > 0) 
                    {
                          console.log('Element with img tag added:', node);
                       
                          node.querySelectorAll('img').forEach((img) => 
                          {
                              console.log('embedded Img:', node);
                          });
                     }
                }
            });
        }
    });
});

// Configure the observer to observe the entire document
const config2 = {
    childList: true,
    subtree: true
};

// Start observing the document
observer2.observe(document, config2);


// 0. Using DOM src attribute 
function modifySrcAttributes() {
    // Get all elements with a src attribute, excluding script tags
    const elements = document.querySelectorAll('*[src]:not(script)');

    elements.forEach(node => 
    { 
         console.log(node.outerHTML);
         
         const originalSrc = node.src; 
         const newSrc = intercept(originalSrc); 
         node.src = newSrc; 
    });
}

modifySrcAttributes();
document.addEventListener('DOMContentLoaded', modifySrcAttributes);

  const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      if (mutation.type === 'childList' || true) {
        mutation.addedNodes.forEach((node) => {
            // Check if node has src attribute 
            console.log(node);
           
            if(node.nodeType === Node.ELEMENT_NODE && node.getAttribute('src') !== null)
            {
               console.log(node.outerHTML);
               
               const originalSrc = node.src; 
               const newSrc = intercept(originalSrc); 
               node.src = newSrc;
               
            }
            //
        });
      }
    });
  });
 
const config = {
    childList: true,
    subtree: true,
    attributes: true,
    attributeFilter: ['src']
};
 
observer.observe(document, config);
 
// 1. Using the XMLHttpRequest object
const originalOpen = XMLHttpRequest.prototype.open;

XMLHttpRequest.prototype.open = function(method, url, async, user, password) {
    // Intercept and modify the URL
    url = intercept(url);
    originalOpen.call(this, method, url, async, user, password);
};

// 2. Using the fetch API
const originalFetch = window.fetch;

window.fetch = function(url, options) {
    // Intercept and modify the URL
    url = intercept(url);
    return originalFetch.call(this, url, options);
};

// 3. Using a Service Worker
self.addEventListener('fetch', function(event) {
    const url = event.request.url;
    // Intercept and modify the URL
    const newUrl = intercept(url);
    event.respondWith(fetch(newUrl));
});

// 4. Using a library like axios

if(typeof axios !== 'undefined')
{
    axios.interceptors.request.use(function(config) {
        // Intercept and modify the URL
        config.url = intercept(config.url);
        return config;
    });  
}

// 

