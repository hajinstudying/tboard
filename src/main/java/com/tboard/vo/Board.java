package com.tboard.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@ToString
public class Board {

	private int boardNo;
	private String title;
	private String content;
	private String memberId;
	private Date regDate;
	
}
