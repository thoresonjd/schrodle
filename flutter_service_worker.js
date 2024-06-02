'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"icons/Icon-maskable-192.png": "8926907fa7e3deea5b7d3f1324acee8d",
"icons/Icon-maskable-512.png": "d4cea75473d50806f433861186b25a40",
"icons/Icon-512.png": "d4cea75473d50806f433861186b25a40",
"icons/Icon-192.png": "8926907fa7e3deea5b7d3f1324acee8d",
"manifest.json": "e859da7c21fd4957afb8698e3c9fcff2",
"favicon.png": "06ca6823c14fe7271da7631fc65405ca",
"flutter_bootstrap.js": "e370fd4d85ccb8f76198f36289820d36",
"version.json": "0f49335428e4774549c38a791e414dbb",
"index.html": "8d8420ac20c3e63fcb93a0c115995524",
"/": "8d8420ac20c3e63fcb93a0c115995524",
"main.dart.js": "314d49f3d8d2897025860926d6d4ddc4",
"assets/AssetManifest.json": "2a143d3cdaddb97e86218654d47e5ef7",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "89ed8f4e49bcdfc0b5bfc9b24591e347",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin.json": "d18668eb996d0a433cb77dfa3c614879",
"assets/fonts/MaterialIcons-Regular.otf": "877ce45b7ac73381a876d62842fd47af",
"assets/assets/images/schrodle-light.png": "466ffb159860ddcd6f1eb81b08cc7475",
"assets/assets/images/schrodle-text-half-inverse.png": "8786ce7d8804a286012c1a2a0d94b35e",
"assets/assets/images/schrodle-s-light.png": "5356bfb395dd53298774a67e0d1859dd",
"assets/assets/images/example-scenario.png": "21e158670814f81016f49071b7347ef3",
"assets/assets/lexicon/guesses": "65bc8ded7257c53652082a66248da80c",
"assets/assets/lexicon/solutions": "9badda8c5bdab2ff8e8cf9cb3130435e",
"assets/assets/fonts/Courier_Prime/CourierPrime-BoldItalic.ttf": "bc1c46723ba3bfa9c2133e95a2491235",
"assets/assets/fonts/Courier_Prime/CourierPrime-Bold.ttf": "4acfa45d29d240044e0075a8e58f0862",
"assets/assets/fonts/Courier_Prime/CourierPrime-Italic.ttf": "87c17bae64044fcbdaf97e4de4a275b3",
"assets/assets/fonts/Courier_Prime/CourierPrime-Regular.ttf": "fba4686ed1d1b4ef05ab14db78805dbe",
"assets/NOTICES": "bfea4f5a8a25d7c4d0c29fcc759d1342",
"assets/AssetManifest.bin": "2576dc0516415ef274da0bdd16a37790",
"assets/FontManifest.json": "c66add0b17ce510d0c60be657b93f147",
"splash/img/light-2x.png": "bdb433fd256d4dbd43e0209cba24d794",
"splash/img/light-1x.png": "32c0417918b1198cb8a40c61dc970c4e",
"splash/img/dark-2x.png": "bdb433fd256d4dbd43e0209cba24d794",
"splash/img/dark-1x.png": "32c0417918b1198cb8a40c61dc970c4e",
"splash/img/dark-4x.png": "08b676c7a5e1476b191d0c61474721a5",
"splash/img/light-4x.png": "08b676c7a5e1476b191d0c61474721a5",
"splash/img/dark-3x.png": "88719117ebc2e9ab9c7b97db25939fa8",
"splash/img/light-3x.png": "88719117ebc2e9ab9c7b97db25939fa8",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
