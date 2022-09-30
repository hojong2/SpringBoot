<%@page import="com.academy.testapp.model.domain.Board"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<!-- React -->
<script src="https://unpkg.com/react@18/umd/react.development.js" crossorigin></script>
<script src="https://unpkg.com/react-dom@18/umd/react-dom.development.js" crossorigin></script>
<script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
<!-- /React -->
<script type="text/babel">
//게시판 목록을 비동기로 가져와서, 동적으로 디자인을 출력하되 (React를 이용하자)
function getList(){
	$.ajax({
		url:"/rest/board/boardList",
		type:"get",
		success:function(result, status, xhr){
			printBoardList(result);
		}
	});
}

function regist(){
	var formArray=$("form").serializeArray();
	var json={};
	for(var i=0; i<formArray.length;i++){
		json[formArray[i].name]=formArray[i].value;
	}
	console.log("전송전 json 구성: ",json);
	
	$.ajax({
		url:"/board/regist",
		type:"post",
		data:JSON.stringify(json), //json을 string 형으로 변환
		contentType:"application/json;charset=utf-8",
		success:function(result, status, xhr){
			getList();
		},
		error:function(xhr, status, error){
			alert(error);
		}
	})
}
function Row(props){
	return(
		<tr>
			<th>{props.board_id}</th>
			<th>{props.title}</th>
			<th>{props.writer}</th>
			<th>{props.content}</th>
			<th>{props.regdate}</th>
			<th>{props.hit}</th>			
		</tr>
	)
	
}

function printBoardList(jsonArray){

	var arr=[];
		for(var i=0; i<jsonArray.length; i++){
			var board=jsonArray[i];
			arr.push(<Row board_id={board.board_id} title={board.title} writer={board.writer} content={board.content} regdate={board.regdate} hit={board.hit}/>)
		}
	var result=(
		<table width="70%" border="1px" align="center"> 
			<tr>
				<th>board_id</th>
				<th>title</th>
				<th>writer</th>
				<th>content</th>
				<th>regdate</th>
				<th>hit</th>
			</tr>
			{arr}
		</table>
	);

	var root=ReactDOM.createRoot(document.getElementById("tableList"));
	root.render(result);
}

</script>
</head>
<body>
	<form>
		<table width="70%" border="1px" align="center">
			<tr>
				<td>제목</td>
				<td><input type="text" name="title"></td>
			</tr>
			<tr>
				<td>작성자</td>
				<td><input type="text" name="writer"></td>
			</tr>
			<tr>
				<td>내용</td>
				<td><textarea name="content"></textarea></td>
			</tr>
			<tr>
				<td colspan="2">
				<button type="button" onClick="regist()">등록</button>
				<button type="button">목록</button>
				</td>
			</tr>
		</table>
	</form>
	<div id="tableList">
	
	<!-- 
		<table width="70%" border="1px" align="center"> 
			<tr>
				<th>board_id</th>
				<th>title</th>
				<th>writer</th>
				<th>content</th>
				<th>regdate</th>
				<th>hit</th>
			</tr>
			<tr>
				<th>board_id</th>
				<th>title</th>
				<th>writer</th>
				<th>content</th>
				<th>regdate</th>
				<th>hit</th>
			</tr>
		</table>
		 -->
	</div>
</body>
</html>