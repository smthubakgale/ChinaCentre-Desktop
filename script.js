//: 
const url = d_config.url + `database/tables?session=${encodeURIComponent(session)}`;
//console.log(url);
    
fetch(url)
.then((response) => response.json())
.then((data) => {
    //console.log(data.success && data.tables.length > 0 , data);

    if (data.success && data.tables.length > 0) {
      const databaseList = document.querySelector('#database-list');
      databaseList.innerHTML = "";
      databaseList.addEventListener('click', toggleCheckbox2)
      const checkbox = document.createElement('input');
      checkbox.type = 'checkbox';
      checkbox.id = 'database';
    
      const label = document.createElement('label');
      label.htmlFor = 'database';
      label.innerHTML = 'Admin <i class="chevron-icon fas fa-chevron-down" style="float:right"></i>';
 
      const unorderedList = document.createElement('ul');
        
      databaseList.prepend(unorderedList);
      databaseList.prepend(label);
      databaseList.prepend(checkbox);
    
    
      data.tables.forEach((table) => {
        const listItem = document.createElement("li");
        const link = document.createElement("a");
        link.href = "#database";
        link.setAttribute('queries', `table=${table}`);
        link.classList.add("nav-link");
        link.innerHTML = `${table.replace(/_/g, ' ').replace(/\b\w/g, (l) => l.toUpperCase())} <i class="fas fa-chevron-right"></i>`;
        listItem.appendChild(link);
        unorderedList.appendChild(listItem);
      });
    }
})
.catch((error) => {
  console.error(error);
    document.querySelectorAll('.menu-list2 ul li').forEach((li) => {
        if (li.innerHTML.trim() === '') {
            li.remove();
        }
    });
});
//
function toggleCheckbox2(event) {
  if (event.target.tagName === 'A') {
    // Existing handleNavLinkClick code here
  } else {
    const checkbox = event.target.parentNode.querySelector('input[type="checkbox"]');
    const label = event.target.parentNode.querySelector('label');
    const chevronIcon = label.querySelector('.chevron-icon');

    if (checkbox.checked) {
      chevronIcon.classList.remove('fa-chevron-down');
      chevronIcon.classList.add('fa-chevron-up');
    } else {
      chevronIcon.classList.remove('fa-chevron-up');
      chevronIcon.classList.add('fa-chevron-down');
    }
  }
}
//:

const loginBtn = document.querySelector('.login-btn');
const loginPopup = document.querySelector('.login-popup');
const loginClose = document.querySelector('.login-close');

// Login Pop Up 
loginBtn.addEventListener('click', () => {
  const screenWidth = window.innerWidth;
  const breakpoint = 768; // Adjust this value to your desired breakpoint

  if (screenWidth >= breakpoint) {
    loginPopup.classList.toggle("pop-show");
  } else {
    handleNavLinkClick(loginBtn, true);
  }
});

loginClose.addEventListener('click', () => {
  loginPopup.classList.remove("pop-show");
});

document.addEventListener('click', function(event) {
  const loginPopup = document.querySelector('.login-popup');
  const loginContainer = document.querySelector('.login-container');
  
  if (loginPopup.contains(event.target) && !loginContainer.contains(event.target)) {
    loginPopup.classList.remove('pop-show');
  }
});
const cartBtn = document.querySelector('.cart-btn');
const cartPopup = document.querySelector('.cart-popup');
const cartClose = document.querySelector('.cart-close');

// Cart Pop Up 
cartBtn.addEventListener('click', () => {
  const screenWidth = window.innerWidth;
  const breakpoint = 768; // Adjust this value to your desired breakpoint

  if (screenWidth >= breakpoint) {
    cartPopup.classList.toggle("pop-show");
  } else {
    handleNavLinkClick(cartBtn, true);
  }
});

cartClose.addEventListener('click', () => {
  cartPopup.classList.remove("pop-show");
});

document.addEventListener('click', function(event) {
  const cartPopup = document.querySelector('.cart-popup');
  const cartContainer = document.querySelector('.cart-container');
  
  if (cartPopup.contains(event.target) && !cartContainer.contains(event.target)) {
    cartPopup.classList.remove('pop-show');
  }
});

// Modals 
const configIcon = document.querySelector('.config-icon');
const modal0 = document.querySelector('.modal');

configIcon.addEventListener('click', () => {
    modal0.style.display = 'block';
});

window.addEventListener('click', (e) => {
    if (e.target === modal0) {
        modal0.style.display = 'none';
    }
});
// Add event listener to dropdown toggle
document.addEventListener("DOMContentLoaded", function() {
  const dropdownToggle = document.querySelector(".dropdown-toggle");

  dropdownToggle.addEventListener("click", function(event) {
    event.preventDefault();
    const dropdownMenu = document.querySelector(".dropdown-menu");
    dropdownMenu.classList.toggle("show");
  });
});

// Get elements
const topNav = document.querySelector('.top-nav');
const sideNav = document.querySelector('.side-nav');
const docsNav = document.querySelector('.docs-nav');
const mainContent = document.querySelector('.main-content'); 
const sections = document.querySelectorAll('.section');
const navLinks2 = document.querySelectorAll('.nav-link');
const subNavTriggers = document.querySelectorAll('.dropdown');
const subNavs = document.querySelectorAll('.sub-nav');
const modals0 = document.querySelectorAll('.modal');
const accordionTriggers = document.querySelectorAll('.accordion');
const alertCloseButtons = document.querySelectorAll('.alert .close-button');
const asideToggle = document.querySelector('.aside-toggle'); 

// Add event listeners
function observeLinkTags(className = '', eventType = 'click', callback = () => {}) 
{
  // Create a MutationObserver instance
  const observer = new MutationObserver((mutations) => {
    mutations.forEach((mutation) => {
      if (mutation.type === 'childList') {
        mutation.addedNodes.forEach((node) => {
          // Check if the added node or its children/sub-children contain the specific class
          checkForClass(node, className);
        });
      }
    });
  });

  // Function to check if a node or its children/sub-children contain a specific class
  function checkForClass(node, className) {
    // Check if the node itself contains the specific class
    if (node.classList && node.classList.contains(className)) { 
      // Add the callback event listener to the new element
      node.addEventListener(eventType, ()=>{
         callback(node , true);
      });
    }
  
    // Recursively check the children and sub-children of the node
    if(node.children){
      Array.from(node.children).forEach((child) => {
        checkForClass(child, className);
      }); 
    }
  }
  
  // Configure the observer to watch for childList changes
  const config = { childList: true, subtree: true };
  
  // Start observing the document body
  observer.observe(document.body, config);
}

// 

function handleNavLinkClick(event , direct = false) {

  //console.log(event , direct);
  
  if(!direct){ event.preventDefault(); } 

  let target = event.target;
  
  // If the target is an <i> element, get its parent
  if(direct){
    target = event;
  }
  if (target.tagName === 'I') {
    target = target.parentNode;
  } 

  const targetSection = target.getAttribute('href').substring(1); 
  var fill = target.getAttribute('fill');
  fill = fill || 'none';
  var queries = target.getAttribute('queries');
  queries = (queries) ? '&queries=' + btoa(queries) : '';

  window.location.href = '?page=' + targetSection + '&fill=' + fill + queries ;
}
//
// Add event listeners
navLinks2.forEach(link => link.addEventListener('click', handleNavLinkClick));
observeLinkTags('nav-link', 'click', handleNavLinkClick);

subNavTriggers.forEach(trigger => trigger.addEventListener('mouseover', handleSubNavTrigger));
subNavTriggers.forEach(trigger => trigger.addEventListener('mouseout', handleSubNavTrigger)); 
accordionTriggers.forEach(trigger => trigger.addEventListener('click', handleAccordionTrigger));
alertCloseButtons.forEach(button => button.addEventListener('click', handleAlertClose));

function clearSections() {
  document.querySelectorAll('section').forEach((section) => {
    section.innerHTML = '';
    section.classList.remove('active');
    section.classList.remove('hidden');
    section.classList.add('hidden');
  });
}


function addSectionIdToJs(jsCode, sectionId) {
  // Use regular expressions to find and modify query selectors
  return   jsCode.replace(/(document\.querySelector|document\.querySelectorAll|jQuery|[$])\s*\(\s*["'](#|\.|)([a-zA-Z0-9_-]+)["']\s*\)/g, (match, p1, p2, p3) => {
    return `${p1}('#${sectionId} ${p2}${p3}')`;
  });
}

function loadPage(pageUrl , queries , fills) {
  console.log("Start");
  session_login(0 , ()=>{
      console.log("Finish");
      clearSections();
    
      fetch('pages/' + pageUrl) 
      .then(response => {
        if (response.ok) {
          return response.text();
        } else {
          throw new Error(`Error: ${response.status}`);
        }
      })
    .then((html) => {   
        // Select all section elements
           const sections = document.querySelectorAll('section'); 
        // Loop through each section
           window["dscript"] = window["dscript"] || [];
    
           window["dscript"].forEach((s)=>
           {
              s.remove();
           });
      
           sections.forEach(section => 
           {
                // Select all style and script elements within the section
                   const stylesAndScripts = section.querySelectorAll('style, script');
          
                // Remove each style and script element
                   stylesAndScripts.forEach(element => element.remove());
            });
      
        const parser = new DOMParser();
        const doc = parser.parseFromString(html, 'text/html'); 
        try{
            doc.querySelectorAll(".design img").forEach(img => img.removeAttribute("src"));
            doc.querySelectorAll(".design").forEach(elem => elem.remove()); 
            doc.querySelectorAll(".blanks").forEach(elem => {elem.style.opacity = 0;}); 
        }catch{}
        const links = doc.querySelectorAll('link');
        const styles = doc.querySelectorAll('style');
        const scripts = doc.querySelectorAll('script');
        const pageContent = doc.body.innerHTML
            .replace(/<script>.*?<\/script>/g, '') // Remove script tags
            .replace(/<style>.*?<\/style>/g, '') // Remove style tags
            .replace(/<link.*?rel="stylesheet".*?>/g, ''); // Remove CSS links
    
        // Load page-specific CSS, HTML, and JS
        const pageName = pageUrl.replace('.html', '');
        const sectionId = `${pageName}`;
        const section = document.getElementById(sectionId);
    
        // Add CSS  
        styles.forEach(style =>{
           const htm = style.innerHTML; 
           if(css){  
             const newStyle = document.createElement('style');
             newStyle.setAttribute('scoped', '');
             newStyle.textContent = css.replace('body', `#${sectionId}`);
             section.prepend(newStyle);
           }
        });
        links.forEach(link => {
          if (link.getAttribute('rel') === 'stylesheet' && link.getAttribute('href').endsWith('.css')) {
            const href = link.getAttribute('href').replace('../', '');
            if(href){
              fetch(href) 
              .then(response => {
                if (response.ok) {
                  return response.text();
                } else {
                  throw new Error(`Error: ${response.status}`);
                }
              })
              .then(css =>
              { 
                  const newStyle = document.createElement('style');
                  newStyle.setAttribute('scoped', '');
                  newStyle.textContent = css.replace('body', `#${sectionId}`); //modifiedCss;
                  section.prepend(newStyle);
              })
              .catch(error => console.error(`Error loading CSS: ${error}`));
              
            }
          }
        });
    
        // Add HTML
        const contentDiv = document.createElement('div');
        contentDiv.innerHTML = pageContent;
      
        const stylesAndScripts2 = contentDiv.querySelectorAll('style, script'); 
        stylesAndScripts2.forEach(element => element.remove());
        
         section.appendChild(contentDiv);
    
        // Add JS
        scripts.forEach(script => {
          let src = script.getAttribute('src');
          const htm = script.innerHTML;
          
          if(htm){
            const jsCode = htm;
            const modifiedJsCode = addSectionIdToJs(jsCode, sectionId); 
            const modifiedScript = document.createElement('script');
            modifiedScript.textContent = modifiedJsCode;
              try{
                section.appendChild(modifiedScript);
                window["dscript"].push(modifiedScript);
               }
              catch(err){
                consoel.error(err);
              }
          }
          else if(src)
          { 
              src = src.replace('../', ''); 
    
              fetch(src)
              .then(response => {
                if (response.ok) {
                  return response.text();
                } else {
                  throw new Error(`Error: ${response.status}`);
                }
              })
              .then(jsCode => { 
                  const modifiedJsCode = addSectionIdToJs(jsCode, sectionId);  
                  const modifiedScript = document.createElement('script');
                  modifiedScript.textContent = modifiedJsCode;
                  try{
                      section.appendChild(modifiedScript);
                      window["dscript"].push(modifiedScript);
                  }
                  catch(err){
                      console.error(err);  
                  }
                })
              .catch(error => console.error(`Error loading JS: ${error}`));
              }
          
        });
       // Display Current Section
          section.classList.remove('hidden');
          section.classList.add('active');
       //
      })
    .catch((error) => console.error(error));
  });
}

// Function to get the query parameter value
function getQueryParameter(name) {
    const urlParams = new URLSearchParams(window.location.search);
    return urlParams.get(name);
}

window.getQueryParams = function (url) {
  const params = new URLSearchParams(url.split('?')[1]);
  const queryParams = {}; 
  
  for (const [key, value] of params) {
    queryParams[key] = value; 
  } 
  
  return queryParams;
}
// Load the page dynamically based on the query parameter
const page = getQueryParameter('page');
var fill = getQueryParameter('fill');
var queries = getQueryParameter('queries'); 

const ur2 = "https://example.com" + ( (queries) ? '?' + atob(queries) : '');
window.queryParam = getQueryParams(ur2);

//console.log(window.queryParam);

renderFill(fill);
function renderFill()
{
  if(fill == "screen"){
   document.querySelector('.top-nav').style.display = 'none';
   document.querySelector('.side-nav').style.display = 'none';
  }
}


if (page) {
    loadPage(page + '.html');
} else { 
    // Load the default page if no query parameter is provided 
    window.location.href = '?page=dashboard&fill=none' ;
    //loadPage('home');
}

function handleNavLinkClick(event , direct = false) {

  if(!direct){ event.preventDefault(); } 

  let target = event.target;
  
  // If the target is an <i> element, get its parent
  if(direct){
    target = event;
  }
  if (target.tagName === 'I') {
    target = target.parentNode;
  } 

  const targetSection = target.getAttribute('href').substring(1); 
  var fill = target.getAttribute('fill');
  fill = fill || 'none';
  var queries = target.getAttribute('queries');
  queries = (queries) ? '&queries=' + btoa(queries) : '';
 
  window.location.href = '?page=' + targetSection + '&fill=' + fill + queries ;
}

function handleSubNavTrigger(event) {
  const subNav = event.target.querySelector('.sub-nav');
  if (event.type === 'mouseover' && subNav) {
  subNav.style.display = 'block';
  } else if(subNav) {
  subNav.style.display = 'none';
  }
}

function handleAccordionTrigger(event) {
const accordionContent = event.target.nextElementSibling;
accordionContent.classList.toggle('show');
}

function handleAlertClose() {
const alert = event.target.parentElement;
alert.remove();
}

function init() 
{
  // Initialize modals
  modals0.forEach(modal0 => {
  const closeButton = modal0.querySelector('.close-button');
  
    if(closeButton)
    {
      closeButton.addEventListener('click', () => modal0.style.display = 'none');
    }
  });
  
  // Initialize tooltips
  const tooltips = document.querySelectorAll('.tooltip');
  tooltips.forEach(tooltip => {
  const trigger = tooltip.querySelector('.tooltip-trigger');
  trigger.addEventListener('mouseover', () => tooltip.classList.add('show'));
  trigger.addEventListener('mouseout', () => tooltip.classList.remove('show'));
  });
}

// Initialize
init();

// Add event listener for window resize
window.addEventListener('resize', () => {
  
  if (window.innerWidth > 768) {
   
  } 
});

asideToggle.addEventListener('click', () => { 
   if(sideNav.classList.contains('mob-nav')){
      sideNav.classList.remove('mob-nav');
   }
   else{
      sideNav.classList.add('mob-nav');
   }
});

document.addEventListener('click', (event) => { 
  if (!docsNav.contains(event.target) && sideNav.contains(event.target)) { 
    sideNav.classList.remove('mob-nav');
  }
});

// Check if mobile device
const isMobile = /Android|webOS|iPhone|iPad|iPod|BlackBerry|IEMobile|Opera Mini/i.test(navigator.userAgent);
