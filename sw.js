const PREFIX='sidequest:'+self.registration.scope+':';
const CACHE=PREFIX+"sidequest-efe8d7e1e54a1f9f";
const FILES=["assets/index-CQ0BlSIi.css","assets/index-s42Tj5bP.js","favicon.svg","icon-bright-180.png","icon-bright-192.png","icon-bright-512.png","icon-v4-180.png","icon-v4-192.png","icon-v4-512.png","index.html","manifest.webmanifest"];
const url=p=>new URL(p,self.registration.scope).href;
self.addEventListener('message',event=>{if(event.data?.type==='SKIP_WAITING')self.skipWaiting();});
self.addEventListener('install',event=>event.waitUntil(caches.open(CACHE).then(cache=>cache.addAll(FILES.map(url)))));
self.addEventListener('activate',event=>event.waitUntil(Promise.all([caches.keys().then(keys=>Promise.all(keys.filter(k=>k.startsWith(PREFIX)&&k!==CACHE).map(k=>caches.delete(k)))),self.clients.claim()])));
self.addEventListener('fetch',event=>{
 const request=event.request,u=new URL(request.url);
 if(request.method!=='GET'||u.origin!==self.location.origin||!request.url.startsWith(self.registration.scope))return;
 if(request.mode==='navigate'){
  event.respondWith((async()=>{const abort=new AbortController();const timer=setTimeout(()=>abort.abort(),3500);try{const response=await fetch(request,{signal:abort.signal});if(response.ok)return response;throw new Error('Unavailable');}catch{return await (await caches.open(CACHE)).match(url('index.html'))||Response.error();}finally{clearTimeout(timer);}})());return;
 }
 const path=request.url.slice(self.registration.scope.length).split('?')[0];
 if(FILES.includes(path))event.respondWith(caches.open(CACHE).then(async cache=>await cache.match(url(path))||fetch(request)));
});
