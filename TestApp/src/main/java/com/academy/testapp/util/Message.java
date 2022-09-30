package com.academy.testapp.util;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor  //매개변수의 개수만큼의 매개변수를 갖는 생성자 자동 정의
public class Message {
	private int code;
	private String msg;
}
