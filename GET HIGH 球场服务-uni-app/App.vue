<script>
	export default {
		onLaunch: function() {
			console.log('App Launch')
		},
		onShow: function() {
			console.log('App Show')
		},
		onHide: function() {
			console.log('App Hide')
		},
		globalData: {
			userInfo: null,
			server:'https://qiubao.ltd/球宝',
			coupons: [],
			total_coupons: 0,
			unpaid: false,   //未支付情况
			unpaid_info: [],  //未支付的订单
			openID: ''      //记录用户的openID
		}
	}
</script>

<style>
	/*每个页面公共css */
</style>
