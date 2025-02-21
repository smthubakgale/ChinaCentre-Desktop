
function intercept(url)
{
   var ur = url;
   console.log(ur);

   return ur;
}

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

