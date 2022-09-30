package com.academy.bootspa.model.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

import lombok.Data;

@Data
@Entity  //하이버네이트를 위한 어노테이션
public class Board {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private int board_id;
	
	private String title;
	private String writer;
	private String content;
	private String regdate;
	private int hit;
}
