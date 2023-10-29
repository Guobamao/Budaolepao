function Main()
	menu = gg.choice({
		"搜索数值",
		"修改数值",
		"退出脚本"
	}, nil, "脚本作者：酷安@Alex009ghc")
	if menu == 1 then
		A()
	end
	if menu == 2 then
		B()
	end
	if menu == 3 then	
		Exit()
	end
	XGCK=-1
end

function A()
	gg.clearResults() --清除搜索结果
	gg.setRanges(2)--设置搜索范围 Jh内存
	gg.searchNumber("42700000h;41F00000h;42C80000h;42C80000h", gg.TYPE_DWORD, false, gg.SIGN_EQUAL, 0, -1, 0)
	gg.toast(gg.getResultsCount())
	t = gg.getResults(50) --获取结果
	-- 搜索到多少条结果
	
end

function B()
	content = gg.prompt({
		"输入修改的公里数(eg: 5(公里))",
		"输入打卡判断距离",
		"输入要修改的步数(会同步修改显示的公里数)",
		"输入跑步的时间(秒, eg: 1800)"
	}, {
		"5",
		"3000",
		"5000",
		"1800"
	})
	-- 如果不为空则执行
	if content ~= nil then
		gg.toast("正在修改公里数")
		gg.setValues({{ address=t[1].address + 0x18, flags=gg.TYPE_FLOAT, value=content[1], freeze=true}} )
		sleep(1000)

		gg.toast("正在修改打卡判断距离")
		gg.setValues({{ address=t[1].address + 0x8, flags=gg.TYPE_FLOAT, value=content[2]}} )
		gg.setValues({{ address=t[1].address + 0x10, flags=gg.TYPE_FLOAT, value=content[2]}} )

		sleep(1000)
		gg.toast("正在修改步数")
		gg.setValues({{ address=t[1].address - 0x48, flags=gg.TYPE_DWORD, value=content[3]}} )

		sleep(1000)
		gg.toast("正在修改跑步时间")
		gg.setValues({{ address=t[1].address - 0x70, flags=gg.TYPE_DWORD, value=content[4]}} )

		sleep(2000)
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