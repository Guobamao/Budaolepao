function Main()
	menu = gg.choice({
		"1. 搜索数值",
		"2. 修改数值",
		"退出脚本"
	}, nil, "脚本作者：酷安@Alex009ghc")
	if menu == 1 then
		Search()
	end
	if menu == 2 then
		Modify()
	end
	if menu == 3 then	
		Exit()
	end
	XGCK=-1
end

function Search()
	gg.clearResults() --清除搜索结果
	gg.setRanges(2)--设置搜索范围 Jh内存
	gg.searchNumber("42700000h;41F00000h;42C80000h;42C80000h", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
	gg.toast(gg.getResultsCount())
	t = gg.getResults(50) --获取结果
	
end

function Modify()
	command = gg.choice({
		"1. 开启自动打卡",
		"2. 推进跑步距离（定向打卡）",
		"3. 修改跑步参数"
	}, nil, "脚本作者：酷安@Alex009ghc")

	if command == 1 then
		AutoCheckIn()
	end

	if command == 2 then
		Forward()
	end

	if command == 3 then
		ModifyParam()
	end

end

function AutoCheckIn()
	gg.toast("正在修改打卡判断距离")
	gg.setValues({{ address=t[1].address + 0x8, flags=gg.TYPE_FLOAT, value=3000 }})
	gg.setValues({{ address=t[1].address + 0xC, flags=gg.TYPE_FLOAT, value=3000 }})
	gg.sleep(1000)
	gg.toast("自动打卡开启成功")
end

function Forward()
	meter = gg.prompt({
		"输入要推进的距离(米)"
	}, {
		"500"
	})

	if meter ~= nil then
		gg.toast("正在修改推进距离")
		original_value = gg.getValues({{ address=t[1].address - 0x4, flags=gg.TYPE_FLOAT }})
		new_value = original_value[1].value + meter[1]
		gg.setValues({{ address=t[1].address - 0x4, flags=gg.TYPE_FLOAT, value=new_value }})
		gg.sleep(1000)
		gg.toast("修改完成, 等待5s生效")
	end
end

function ModifyParam()
	param = gg.prompt({
		"输入要修改的步数",
		"输入跑步的时间(秒, eg: 1800)"
	}, {
		"5000",
		"1800"
	
	})

	if param ~= nil then
		gg.toast("正在修改步数")
		gg.setValues({{ address=t[1].address - 0x1C, flags=gg.TYPE_DWORD, value=param[1] }})
		gg.sleep(1000)
		gg.toast("正在修改跑步时间")
		gg.setValues({{ address=t[1].address - 0x74, flags=gg.TYPE_DWORD, value=param[2] }})
		gg.sleep(1000)
		gg.toast("修改完成")
	end
end

function Exit()
	print("脚本已退出")
	os.exit()
end 
while true do 

	if gg.isVisible(true) then 
		XGCK = 1 
		gg.setVisible(false)
	end 
	gg.clearResults() 
	if XGCK == 1 then 
		Main()
	end 
end