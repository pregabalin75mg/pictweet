$(function(){
  function buildHTML(comment){
    var html = `<p>
                  <strong>
                    <a href=/users/${comment.user_id}>${comment.user_name}</a>
                    ：
                  </strong>
                  ${comment.text}
                </p>`
    return html;
  }
  $('#new_comment').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var url = $(this).attr('action');
    $.ajax({
      url: url,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      var html = buildHTML(data);
      $('.comments').append(html);
      $('.textbox').val('');
      $('.form__submit').prop('disabled', false);     // disable属性はボタンを押せなくさせるようにするもの。それをfalseにした
    })
    .fail(function(){
      alert('error');
    })
  })
});
// onメソッドの構文
// => 対象要素(id名 new_comment(view/show/html で定義してる)).on( イベント名(submit(フォームが送信された時)), セレクタ, データ ,関数 )
// 送信ボタン(form.submit)自身のクラス名である"form__submit"に on メソッドは使わない。form全体を定義するid名につける。