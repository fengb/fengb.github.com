!function(window, document){
  var insertScript = function(src, newTag, loadedTag){
    newTag = document.createElement('script')
    newTag.async = 1
    newTag.src = src
    loadedTag = document.getElementsByTagName('script')[0]
    loadedTag.parentNode.insertBefore(newTag, loadedTag)
  }

  window.GoogleAnalyticsObject = 'ga'
  window.ga = {
    l: +new Date(),
    q: [['create', 'UA-34997099-2', 'fengb.info'], ['send', 'pageview']]
  }
  insertScript('//www.google-analytics.com/analytics.js')
}(window, document)
