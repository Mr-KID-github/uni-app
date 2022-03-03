<script>
	export default {
		onLaunch: function() {
			console.log('App Launch')
			var that = this
			// 获取用户唯一标识 openID
			uni.login({
			  // provider: 'weixin',
			  success: function (loginRes) {
			    // console.log(loginRes.code);
				uni.request({
					url: getApp().globalData.server + '/index.php/Home/GuoFeng/getOpenid',
					data:{
						"code": loginRes.code
					},
					method:"POST",
					header: {
						'content-type': "application/x-www-form-urlencoded"
					},
					dataType: 'json',
					success:function(res){
						// 将其储存到全局中
						console.log("登录成功")
						that.globalData.openid = res.data.openid
						uni.request({
							url: getApp().globalData.server + '/index.php/Home/GuoFeng/findAddress',
							data:{
								'user_id': res.data.openid,
							},
							method:"POST",
							header: {
								'content-type': "application/x-www-form-urlencoded"
							},
							dataType: 'json',
							success:function(res){
								console.log(res)
								if (res.data.error_code == 0){
									console.log("成功获取用户地址")
									console.log(res.data.data)
									getApp().globalData.position['phone'] = res.data.data.phone
									getApp().globalData.position['school'] = res.data.data.school
									getApp().globalData.position['apartment'] = res.data.data.apartment
									getApp().globalData.position['dormitory'] = res.data.data.dormitory
								}
							},
							fail:function(res){
								console.log(res)
							}
						})
						
					},
					fail:function(res){
						var there = that
						console.log("登录失败,请重新进入尝试...")
						uni.showModal({
							showCancel:false,
							content:"登录失败,请重新进入尝试..."
						})
					}
				})
			  }
			});
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		},
		globalData: {
			order:{
				goods: [],	//订单的所有商品
				position:'',//配送地址信息
				order_time:'',//建立订单信息
				order_money:'',//订单金额
				order_phone: '', //订单联系电话
			},//提交的订单信息
			openid: "",
			server:'https://qiubao.ltd/果宝',
			cert: [],	// 购物车
			custom_cert: [], //定制购物车
			select_plan: '', //选择的方案
			total_price: 0, //总价
			position:{
				"phone": "",	//手机号（在页面初始化时从数据中提取）
				"school": "",	//学校（在页面初始化时从数据中提取）
				"apartment": "",	//公寓号（在页面初始化时从数据中提取）
				"dormitory": "", //寝室号（在页面初始化时从数据中提取）
			},
			plan1_num:{
				"guocha":0,
				"totalguocha":2,
				"guolao":0,
				"totalguolao":1,
				"guopan":0,
				"totalguopan":2,
			},
			plan2_num:{
				"guocha":0,
				"totalguocha":3,
				"guolao":0,
				"totalguolao":3,
				"guopan":0,
				"totalguopan":3,
			},
			plan3_num:{
				"guocha":0,
				"totalguocha":50,
				"guolao":0,
				"totalguolao":50,
				"guopan":0,
				"totalguopan":50,
			},
			
		}
	}
</script>

<style>
	/*每个页面公共css */
</style>
