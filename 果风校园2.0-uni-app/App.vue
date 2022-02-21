<script>
	export default {
		onLaunch: function() {
			console.log('App Launch')
			var that = this
			// 获取用户唯一标识 openID
			uni.login({
			  provider: 'weixin',
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
			openid: "",
			server:'https://qiubao.ltd/果宝',
			cert: [],	// 购物车
			custom_cert: [
				// {
				// 	'plan_name': '方案一',
				// 	'goods_name': '苹果',
				// 	'goods_introduct': '营养价值高，富含丰富维C',
				// 	'goods_img': '/static/img/fruit1.jpg',
				// 	'is_extend': false,		//是否加价
				// },
				// {
				// 	'plan_name': '方案一',
				// 	'goods_name': '香蕉',
				// 	'goods_introduct': '营养价值高，富含丰富维C',
				// 	'goods_img': '/static/img/fruit2.jpg',
				// 	'is_extend': false,		//是否加价
				// }
			], //定制购物车
			total_price: 0, //总价
			position:{
				"phone": "",	//手机号（在页面初始化时从数据中提取）
				"school": "",	//学校（在页面初始化时从数据中提取）
				"apartment": "",	//公寓号（在页面初始化时从数据中提取）
				"dormitory": "", //寝室号（在页面初始化时从数据中提取）
			}
		}
	}
</script>

<style>
	/*每个页面公共css */
</style>
