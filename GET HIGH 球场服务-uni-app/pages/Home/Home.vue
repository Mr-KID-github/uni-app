<template>
	<view>
		<image @click="login" class="login" src="/static/img/login.png" v-if="!userInfo.avatarUrl"></image>
		
		<view class="all">
		<view class="mine">
			<!-- 字体+头像栏部分 -->
			<view class="item_text_image">
			  <view class="item_text">
				<text class="text_1">Hello</text>
				<text class="text_2">{{userInfo.nickName}}</text>
			  </view>
			  <image @click="bindViewTap" class="userinfo-avatar" :src="userInfo.avatarUrl" mode="cover"></image>
			</view>
			<view class="user_info">
			  <view class="paid">
				<view class="pay_num"> 
				  <view class="pay_num_item">已购饮品：</view><text>{{ pdrink }}次</text>
				</view>
				<view class="line"></view>
				<view class="pay_num">
				  <view class="pay_num_item">租赁篮球：</view><text>{{ pball }}次</text>
				</view>
				<view class="line"></view>
				<view class="pay_num">
				  <view class="pay_num_item">应急处理：</view><text>{{ pkit }}次</text>
				</view>
			  </view>
			  <view class="qiubaocard" @click="to_buy_ballcard">
				<image :src="qiucard_url" mode="scaleToFill"></image>
			  </view>
			</view>
		</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				//组件tab_bar中的“首页”和“我的”
				currentid1: "未点击首页",
				currentid2: "点击我的",
				unpaid_info:[],
				bill_info: [],
				navbar: ['未支付', '全部'],
				currentTab: 0,
				currentContent: '未支付',
				pdrink: 0,
				pkit: 0,
				pball: 0,
				qiucard_url: getApp().globalData.server + '/Data/img/to_ball_card.png'
			}
		},
		methods: {

		}
	}
</script>


<style>
	
	page{
	  background: white;
	}
	
	.login{
	  position: absolute;
	  top: 20rpx;
	  right: 80rpx;
	  width: 100rpx;
	  height: 60rpx;
	}
	
	.all{
	  /* 小程序中，窗口高度固定为100vh ，将窗口高度平均分成100份，1份是1vh */
	  height: 100vh;  
	  background-color: #F2F2F2;  
	}
	
	.mine{
	  height: 18%;
	  display: flex;
	  flex-direction: column;
	  justify-content: space-around;
	  background-color: white;
	}
	
	.user_info{
	  width: 100%;
	  /* display: flex;
	  justify-content: space-around; */
	
	}
	
	.qiubaocard{
	  display: flex;
	  justify-content: center;
	  width: 100%;
	  margin-top: 20rpx;
	}
	
	.qiubaocard image{
	  width: 94%;
	  height: 280rpx;
	  border-radius: 15rpx;
	}
	
	.paid{
	  display: flex;
	  width: 70%;
	  margin-top: 80rpx;
	  justify-content: space-around;
	}
	
	.pay_num{ 
	
	
	  font-family: ZCOOL KuaiLe;
	  font-style: normal;
	  font-weight: normal;
	  font-size: 30rpx;
	
	
	  display: flex;
	  flex-direction: column;
	  justify-content: space-around;
	  
	  color: #979797;
	
	  text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	}
	
	.pay_num text{
	  font-size: medium;
	  color: #000000;
	}
	
	.line{
	  border: 2rpx solid #DFE4EA;
	
	  width: 0rpx;
	  height: 100rpx;
	
	}
	
	.scroll_bill{
	  height: 52%;
	  background-color: #F2F2F2;
	}
	/* 字和头像组 */
	.item_text_image{
	  margin-left: 20px;
	  margin-right: 20px;
	  height: 45px;
	  display: flex;
	  justify-content: space-between;
	  align-items: center;
	  padding-top: 10rpx;
	}
	
	/* 字组 */
	.item_text{
	  display: flex;
	}
	
	/* 头像 */
	.userinfo-avatar {
	  width: 100rpx;
	  height: 100rpx;
	  border-radius: 10px;
	  margin-top: 362rpx;
	}
	
	/* 字1 */
	.text_1{
	  display: flex;
	  font-size:18px; color: black; 
	}
	
	/* 字2 */
	.text_2{
	  display: flex;
	  margin-left: 10px;
	  font-style: italic;font-weight: 800;
	  font-size:18px; color: black; 
	}
	
	.interface{
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	  justify-content: center;
	  background-color: #F2F2F2;
	  padding-bottom: 20rpx;
	}
	
	.frame{
	  border-radius: 40rpx;
	  background: #FFFFFF;
	  box-shadow: 8rpx 8rpx 8rpx 0rpx #a7a5a5;
	  margin-top: 60rpx;
	  margin-bottom: 20rpx;
	  width: 630rpx;
	  height: 400rpx;
	}
	
	.info_1{
	  margin-left: 52rpx;
	  margin-right: 52rpx;
	  width: 526rpx;
	  display: flex;
	  justify-content: space-between;
	  margin-top: 30rpx;
	}
	
	.place{
	  color: #000000;
	font-family: Roboto;
	font-weight: 900;
	font-size: 25rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	
	position: relative;
	left: 0rpx;
	}
	
	.device{
	  color: #000000;
	font-family: Roboto;
	font-weight: regular;
	font-size: 20rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	}
	
	.bill_state{
	  color: #000000;
	font-family: Roboto;
	font-weight: regular;
	font-size: 24rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	position: relative;
	right: 0rpx;
	}
	
	.info_2{
	  margin-left: 52rpx;
	margin-right: 52rpx;
	width: 526rpx;
	display: flex;
	justify-content: space-between;
	margin-top: 4rpx;
	}
	
	.service_type{
	  color: #000000;
	  font-family: Roboto;
	  font-weight: regular;
	  font-size: 20rpx;
	  line-height: 50rpx;
	  letter-spacing: 0rpx;
	  text-align: center;
	
	  
	}
	
	image{
	  width: 52rpx;
	  height: 52rpx;
	
	}
	
	.service_time{
	  color: #C4C4C4;
	font-family: Roboto;
	font-weight: regular;
	font-size: 24rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	
	}
	
	.service_unit_price{
	  color: #000000;
	font-family: Roboto;
	font-weight: regular;
	font-size: 30rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	
	}
	
	.service_num{
	  color: #000000;
	font-family: Roboto;
	font-weight: regular;
	font-size: 40rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	
	}
	
	.divider{
	  width: 540rpx;
	  height: 0rpx;
	  border: 2rpx solid #000000;
	  margin-left: 45rpx;
	  margin-top: 2rpx;
	}
	
	.info_3{
	margin-left: 52rpx;
	margin-right: 52rpx;
	width: 526rpx;
	display: flex;
	justify-content: space-between;
	margin-top: 4rpx;
	}
	
	.discount{
	  color: #C62626;
	font-family: Roboto;
	font-weight: regular;
	font-size: 24rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	position: relative;
	bottom: -40rpx;
	}
	
	.info_3_item{
	  height: 100rpx;
	}
	
	.coupons_content{
	  color: #000000;
	font-family: Roboto;
	font-weight: regular;
	font-size: 20rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	position: relative;
	top: -20rpx;
	}
	
	.coupons_title{
	  color: #000000;
	font-family: Roboto;
	font-weight: 600;
	font-size: 24rpx;
	
	letter-spacing: 0rpx;
	text-align: center;
	position: relative;
	top: -18rpx;
	margin-left: 12rpx;
	
	}
	
	.info_4{
	  margin-left: 52rpx;
	  margin-right: 52rpx;
	  width: 526rpx;
	  display: flex;
	  justify-content: space-between;
	  margin-top: 4rpx;
	  align-items: center;
	}
	
	.already_discount{
	  color: #979797;
	font-family: Roboto;
	font-weight: regular;
	font-size: 24rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	position: relative;
	left: 200rpx;
	
	}
	
	.react_pay{
	  color: #000000;
	font-family: Roboto;
	font-weight: 700;
	font-size: 30rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	}
	
	.info_5{
	  margin-left: 52rpx;
	  margin-right: 52rpx;
	  width: 526rpx;
	  display: flex;
	  justify-content: space-between;
	  margin-top: 4rpx;
	}
	
	.order_time{
	  color: #C4C4C4;
	font-family: Roboto;
	font-weight: regular;
	font-size: 24rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	}
	
	.order_id{
	  color: #C4C4C4;
	  font-family: Roboto;
	  font-weight: regular;
	  font-size: 24rpx;
	  line-height: 50rpx;
	  letter-spacing: 0rpx;
	  height: 50rpx;
	  position: relative;
	  bottom: 10rpx;
	  
	}
	
	.order_bottom{
	  position: relative;
	  top: 20rpx;
	  display: flex;
	  justify-content: center;
	  align-items: center;
	  border-radius: 40rpx;
	  border: 2rpx solid #000000;
	  width: 146rpx;
	  height: 48rpx;
	}
	
	.order_bottom text{
	color: #000000;
	font-family: Roboto;
	font-weight: regular;
	font-size: 24rpx;
	line-height: 50rpx;
	letter-spacing: 0rpx;
	text-align: center;
	}
	
	/* ------------------------------- */
	
	.navbar{
	  flex: none;
	  display: flex;
	  height: 7%;
	  background-color: white;
	  padding-top: 24%;
	}
	.navbar .item{
	  position: relative;
	  flex: auto;
	  text-align: center;
	  line-height: 80rpx;
	}
	.navbar .item.active{
	  color: #FFCC00;
	}
	.navbar .item.active:after{
	  content: "";
	  display: block;
	  position: absolute;
	  bottom: 0;
	  left: 20%;
	  right: 20%;
	  height: 5rpx;
	  width: 60%;
	  background: #FFCC00;
	}
	
	.problem{
	  font-size: x-small;
	  color: dimgray;
	  text-align: center;
	  margin-top: 22rpx;
	  background-color: #F2F2F2;
	}
	
	.noPay{
	  position: relative;
	  width: 750rpx;
	  height: 650rpx;
	  bottom: 0;
	  top: 230rpx;
	  
	  display: flex;
	  flex-direction: column;
	  text-align: center;
	}
	.noPay_img{
	  width: 200rpx;
	  height: 200rpx;
	  margin-left: 298rpx;
	  margin-top: 22rpx;
	}
	
	.noPay_text{
	  font-size: 34rpx;
	  font-family: STSongti-SC-Black;
	  background:linear-gradient(131deg,rgb(129, 129, 129) 50%,rgb(58, 58, 58) 100%);
	  -webkit-background-clip: text;
	  background-clip: text;
	  color: transparent;
	  text-shadow:0px 2px 2px 0px rgba(69,69,69,1);
	}
	
</style>
