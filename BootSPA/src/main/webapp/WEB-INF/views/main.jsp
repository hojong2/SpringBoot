<%@ page contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
<script type="text/babel">
//동기 방식 전송
function regist(){
	$("#input-form").attr({
		action:"/board/regist",
		method:"post"
	});
	$("#input-form").submit();
}
//비동기방식의 기존폼을 이용한 Parameter 문자열 전송
function registBySerial(){
	var params=$("#input-form").serialize();
	console.log(params);
	
	//이미 전송할 파라미터화가 완료되었으므로, json으로 변환하지 말고 그냥 보내보자
	$.ajax({
		url:"/rest/serial/board",
		type:"post",
		data:params,
		contentType:"application/x-www-form-urlencoded;charset=utf-8",
		success:function(result, status, xhr){
			getList();
		},
		error:function(xhr, status, error){
			alert(error.msg);
		}
	});
}
//비동기방식의 기존폼을 이용한 Json 문자열 전송
function registByJson(){
	var formArray=$("#input-form").serializeArray();
	console.log(formArray);
	var json={};
	for(var i =0; i<formArray.length; i++){
		json[formArray[i].name]=formArray[i].value;
	}
	console.log(json);
	
	$.ajax({
		url:"/rest/json/board",
		type:"post",
		data:JSON.stringify(json),
		contentType:"application/json; charset=utf-8",
		success:function(result, status, xhr){
			getList();
		},
		error:function(xhr, status, error){
			alert(error.msg);
		}
	})
}

//비동기 방식으로 한건의 데이터 가져오기
function getDetail(board_id){
	$.ajax({
		url:"/rest/board/"+board_id,
		type:"get",
		success:function(result, status, xhr){
			printBoard(result);
		}
	});
	
}

// 우측 영역에 폼 한 건 출력
function printBoard(board) {
   $("#detail-form input[name='board_id']").val(board.board_id);
   $("#detail-form input[name='title']").val(board.title);
   $("#detail-form input[name='writer']").val(board.writer);
   $("#detail-form textarea[name='content']").val(board.content);
}

//비동기 방식으로 목록 가져오기
function getList(){
	$.ajax({
		url:"/rest/board",
		type:"get",
		success:function(result, status, xhr){
			console.log("받은 json", result);
			printList(result);
		}
	});
}
function Row(props){
	var link = "javascript:getDetail("+props.board_id+")";
	return (
		<tr align="center">
			<td>{props.board_id}</td>
			<td><a href={link}>{props.title}</a></td>
			<td>{props.writer}</td>
			<td>{props.regdate}</td>
			<td>{props.hit}</td>
		</tr>
	)
}

function BoardTable(props){
	var list= props.boardList;
	//tr을 반복한 컨텐츠를 구성
	var tag=[];  //여기에 tr을 모아둘 것임
	for(var i=0; i<list.length; i++){
		var board = list[i];
		tag.push(<Row board_id={board.board_id} title={board.title} writer={board.writer} regdate={board.regdate} hit={board.hit}/>);
	}
	
	return (
		<table width="100%" border="1px">
			<thead>
				<tr>
					<th>No</th>
					<th>제목</th>
					<th>작성자</th>
					<th>등록일</th>
					<th>조회수</th>
				</tr>
			</thead>
			<tbody>
				{tag}
			</tbody>
		</table>
	);
}

//React를 이용한 UI 처리
function printList(jsonArray){
	var root=ReactDOM.createRoot(document.getElementById("list-area"));
	root.render(<BoardTable boardList={jsonArray} />);
}

//수정 요청
function edit(){
	//비동기 요청시 기존 폼을 이용하는 법(파라미터 방식, json 전송)
	var params= $("#detail-form").serialize();  // 파라미터=값&파라미터=값 형식의 쿼리 스트링
	if(confirm("수정하시겠어요?")){
		$.ajax({
			url:"/rest/board",
			type:"PUT",
			data:params,
			contentType:"application/x-www-form-urlencoded; charset=utf-8",
			success:function(result, status, xhr){
				alert(result.msg);
				getList();
			}
		});
	}
}
//삭제 요청
function del(){
	if(confirm("삭제하시겠어요?")){
		$.ajax({
			url:"/rest/board?board_id="+$("#detail-form input[name='board_id']").val(),
			type:"delete",
			success:function(result, status, xhr){
				getList();
			},
			error:function(xhr, status, result){
				alert(error);
			}
		});
	}
}
$(function(){
	getList();
	$($("#input-area button")[0]).click(function(){
		regist();
	});
	$($("#input-area button")[1]).click(function(){
		registBySerial();
	});
	$($("#input-area button")[2]).click(function(){
		registByJson();
	});
	$($("#detail-area button")[0]).click(function(){
		edit();
	});
	$($("#detail-area button")[1]).click(function(){
		del();
	});
})
</script>
<style type="text/css">
body{margin:0px;}
#wrapper{
	width:100%;
	height:700px;
	overflow:hidden;
}
#input-area{
	width:20%;
	height:100%;
	float:left;
	background:blue;
}
#input-area input, #detail-area input, #list-area input{
	width:97%;
}
#list-area{
	width:60%;
	height:100%;
	float:left;
	background:yellow;
	overflow:scroll;
}
#detail-area{
	width:20%;
	height:100%;
	float:left;
	background:skyblue;
}
</style>
</head>
<body>
	<div id="wrapper">
		<div id="input-area">
			<form id="input-form">
				<input type="text" name="title" placeholder="제목입력">
				<input type="text" name="writer" placeholder="작성자입력">
				<textarea style="width:98%; height:150px;" name="content"></textarea>
				<button type="button">동기 등록</button>
				<button type="button">비동기 등록(파라미터)</button>
				<button type="button">비동기 등록(json)</button>
			</form>
		</div>
		
		<div id="list-area">
		</div>
		
		<div id="detail-area">
			<form id="detail-form">
				<input type="text" name="board_id">
				<input type="text" name="title" placeholder="제목입력">
				<input type="text" name="writer" placeholder="작성자입력">
				<textarea style="width:98%; height:150px;" name="content"></textarea>
				<button type="button">수정</button>
				<button type="button">삭제</button>
			</form>
		</div>
	</div>
</body>
</html>