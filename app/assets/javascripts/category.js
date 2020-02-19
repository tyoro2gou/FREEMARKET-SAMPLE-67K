$(function(){
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChidrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<select id="child_category" name="item[category_id]">
                        <option value="---">---</option>
                        ${insertHTML}
                      <select>`;
    $('.category-box').append(childSelectHtml);
  }
  // 親カテゴリー選択後のイベント
  $('#item_category_id').on('change', function(){
    var parentValue = document.getElementById('item_category_id').value; //選択された親カテゴリーの名前を取得
    if (parentValue !== 1){ //親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/children_category',
        type: 'GET',
        data: { parent_id: parentValue },
        dataType: 'json'
      })
      .done(function(children){
        $('#child_category').remove(); //親が変更された時、子を削除
        $('#selected_child_category').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChidrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#child_category').remove(); //親カテゴリーが初期値になった時、子を削除
      $('#selected_child_category').remove();
    }
  });
});