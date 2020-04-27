$(function() {
  $('.jscroll').jscroll({
    // 無限に追加する要素は、どこに入れる？
    contentSelector: '.jscroll', 
    // 次のページにいくためのリンクの場所は？ ＞aタグの指定
    nextSelector: 'a.next',
    // 読込中はスピナー表示
    loadingHtml: `
      <div class="sk-chase">
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
        <div class="sk-chase-dot"></div>
      </div>
    `
  });
});