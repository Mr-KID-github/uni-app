<template>
	<view class="content">
		<!-- 轮播图 -->
		  <swiper autoplay="true" interval="5000" duration="500"  circular="true">
			<block v-for="item in bcg">
			  <swiper-item class="Auto_Layout">
				  <image :src="item" mode="scaleToFill" class="Auto_Layout_images"></image>
			  </swiper-item>
			</block>
		  </swiper>
		<!-- 冷饮框架 -->
		  <view class="Drink" style="width: 658rpx; height: 324rpx; display: block; box-sizing: border-box; left: 47rpx; top: 452rpx; position: absolute"></view>
		  <view class="divider_buygroup" style="position: absolute; left: 64rpx; top: 712rpx"></view>
		  <view class="All_Drink">
			<view  @click="showModal" id="Drink_Frame">   
			  <view class="divider" style="width: -2rpx; height: 162rpx; display: block; box-sizing: border-box; left: 398rpx; top: 509rpx; position: absolute"></view>
			  <text class="Drink_title" style="position: absolute; left: 43rpx; top: 498rpx; width: 354rpx; height: 120rpx; display: flex; box-sizing: border-box">冷饮售卖</text>
			  <text class="Drink_content" style="position: absolute; left: 78rpx; top: 619rpx">快速下单，不用等</text>
			  <image class="Drink_icon" src="/static/img/Drink_icon.png" style="position: absolute; left: 402rpx; top: 378rpx"></image>
			</view>
			<view class="group_buy" @click="to_appointment" style="position: absolute; left: 0rpx; top: 724rpx">
			  <image class="buy_img1" src="/static/img/Group_Purchase.png" style="width: 242rpx; height: 40rpx; display: inline-block; box-sizing: border-box; left: NaNrpx; top: NaNrpx"></image>
			  <image class="buy_img2" src="/static/img/Purchase.png"></image>
			  <image class="buy_img4" src="/static/img/appointment.png"></image>
			  <text class="buy_text" style="position: relative; left: -29rpx; top: -11rpx">Get HIGH!更便宜</text>
			  <image class="buy_img3" src="/static/img/arrow.png"></image>
			</view>
		  </view>
		  <!-- 其他框架 -->
		  <view id="Ball_Frame" @click="showModal">
			<view class="Basketball_Frame" style="position: absolute; left: 32rpx; top: 835rpx"></view>
			<!-- 内容 -->
			<text class="basketball_title" style="position: absolute; left: 70rpx; top: 891rpx">篮球租赁</text>
			<text class="basketball_content" style="position: absolute; left: 70rpx; top: 965rpx">没球？开玩笑</text>
			<view class="bask_line" style="position: absolute; left: 231rpx; top: 876rpx; width: 0rpx; height: 120rpx; display: block; box-sizing: border-box"></view>
			<image class="bask_icon" src="/static/img/play_bask.png" style="position: absolute; left: 238rpx; top: 876rpx"></image>
		  </view>
		  
		  <view @click="showModal" id="Medical_Frame">
			<view class="Medical_Frame" style="position: absolute; left: 399rpx; top: 835rpx"></view>
			<text class="medicine_title" style="position: absolute; left: 429rpx; top: 891rpx">应急医护</text>
			<text class="medicine_content" style="position: absolute; left: 426rpx; top: 965rpx">受伤了？找我</text>
			<view class="medicine_line"></view>
			<image class="medicine_icon" src="/static/img/medicine_icon.png" style="position: absolute; left: 603rpx; top: 876rpx"></image>
		  </view>

		  <view id="Coupons_Frame" @click="showModal">
			<view class="Coupons_Frame"  style="position: absolute; left: 46rpx; top: 1078rpx"></view>
			<text class="my_Coupons_title" style="position: absolute; left: 74rpx; top: 1135rpx">我的优惠卷</text>
			<text class="my_Coupons_num" style="position: absolute; left: 298rpx; top: 1135rpx">{{ total_coupons }}</text>
			<text class="my_Coupons_unit" style="position: absolute; left: 338rpx; top: 1135rpx">张</text>
			<text class="my_Coupons_content" style="position: absolute; left: 75rpx; top: 1205rpx">付款时自动抵扣</text>
			<image class="my_Coupons_icon" src="/static/img/my_Coupons_icon.png" style="position: absolute; left: 359rpx; top: 1120rpx"></image>
		  </view>

		  <view class="device">
			<image src="/static/img/device.png" style="height: 100rpx; width: 100rpx;"></image>
			<text>设备：{{ device_id }}{{ Frame }}</text>
		  </view>

		  <view class="wrap">
			<!-- modal点击弹窗  -->
			<view class="modal modal-bottom-dialog" :hidden="hideFlag">
			  <view class="modal-cancel" @click="hideModal"></view>
			  <view class="bottom-dialog-body bottom-positon" :animation="animationData">
				<!-- 父组件向子组件传值 -->
				<Componentcoupons v-if="Frame=='Coupons_Frame'"  @exit="hideModal" :coupons="coupons"  :total_coupons="total_coupons"></Componentcoupons>
				<Componentdrink v-if="Frame=='Drink_Frame'" @exit="hideModal"></Componentdrink>   
				<Componentball v-if="Frame=='Ball_Frame'" @exit="hideModal"></Componentball>
				<Componentmedical v-if="Frame=='Medical_Frame'" @exit="hideModal"></Componentmedical>   
			  </view>
			</view>
		  </view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				//默认device_id为无
				device_id: '无',
				//组件tab_bar中的“首页”和“我的”
				currentid1: "点击首页",
				currentid2: "未点击我的",
				bcg: [
				  getApp().globalData.server + '/Data/img/system_preferences.png',
				],
				Frame:[],
				hideFlag: true,//true-隐藏  false-显示
				animationData: {},//动画数据
				coupons: [],
				total_coupons: 0
			}
		},
		methods: {
			//取消
			mCancel: function () {
						var that = this;
						that.hideModal();
			},
			// 显示遮罩层
			showModal: function (e) {
				console.log("已点击弹框模块:" + e.currentTarget.id)
				// 根据传入的id判断打开弹窗
				this.Frame = e.currentTarget.id
				console.log(this.Frame) 

				var that = this;
				this.hideFlag = false
				
				// 创建动画实例
				var animation = uni.createAnimation({
				 duration: 500,//动画的持续时间
				 timingFunction: 'ease',//动画的效果 默认值是linear->匀速，ease->动画以低速开始，然后加快，在结束前变慢
				})
				this.animation = animation; //将animation变量赋值给当前动画,全局都可以用
				var time1 = setTimeout(function () {
				 that.slideIn();//调用动画--滑入
				 clearTimeout(time1);
				 time1 = null;
				}, 100)
			},
			// 隐藏遮罩层
			hideModal: function () {
			    var that = this;
			    var animation = wx.createAnimation({
			      duration: 400,//动画的持续时间 默认400ms
			      timingFunction: 'ease',//动画的效果 默认值是linear
			    })
			    this.animation = animation
			    that.slideDown();//调用动画--滑出
			    var time1 = setTimeout(function () {
			      that.hideFlag = true
			      clearTimeout(time1);
			      time1 = null;
			    }, 220)//先执行下滑动画，再隐藏模块   
			},
			//动画 -- 滑入
			slideIn: function () {
				this.animation.translateY(0).step() // 在y轴偏移，然后用step()完成一个动画
				//动画实例的export方法导出动画数据传递给组件的animation属性
				this.animationData = this.animation.export()
			},
			//动画 -- 滑出
			slideDown: function () {
				this.animation.translateY(600).step()
				this.animationData = this.animation.export()
			},
		}
	}
</script>

<style>
	.page_background{
	  position: relative;
	  z-index: 1;
	}
	
	swiper{
	  height: 350rpx;
	}
	
	.Auto_Layout{
	  /* Auto Layout */
	  filter: drop-shadow(0px 8rpx 8rpx rgba(0, 0, 0, 0.25));
	}
	
	.Auto_Layout_images{
	width: 100%;
	height: 326rpx;
	border-radius: 0px 0px 80rpx 80rpx;
	filter: drop-shadow(0px 8rpx 8rpx rgba(0, 0, 0, 0.25));
	}
	
	/* 冷饮售卖框 */
	.Drink{
	  /* Drink */
	
	position: absolute;
	top: 388rpx;
	height: 324rpx;
	width: 452rpx;
	left: 47rpx;
	right: 28rpx;
	/* 极其淡蓝色 */
	
	background: linear-gradient(109.28deg, #BADAF9 0%, rgba(119, 190, 255, 0) 100%);
	opacity: 0.1;
	border: 2rpx solid #000000;
	filter: drop-shadow(20rpx 20rpx 6rpx #212529);
	border-radius: 20rpx;
	}
	
	.divider{
	  position: absolute;
	  top: 509rpx;
	  height: 162rpx;
	  left: 398rpx;
	  right: 408rpx;
	  border: 2rpx solid #DFE4EA;
	}
	
	.Drink_title{
	position: absolute;
	opacity: 1;
	width: 354rpx;
	height: 120rpx;
	left: 43rpx;
	top: 498rpx;
	/* font-family: ZCOOL KuaiLe; */
	font-style: normal;
	font-weight: normal;
	font-size: 61rpx;
	line-height: 66rpx;
	display: flex;
	align-items: center;
	justify-content: center;
	text-align: center;
	
	color: #000000;
	
	text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	}
	
	.Drink_content{
	position: absolute;
	top: 619rpx;
	left: 78rpx;
	
	
	color: #8C8C8C;
	text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	/* font-family: ZCOOL QingKe HuangYou; */
	font-weight: regular;
	font-size: 37rpx;
	line-height: normal;
	letter-spacing: 0rpx;
	text-align: left;
	
	}
	
	.Drink_icon{
	  /* box-shadow: 0rpx 8rpx 8rpx 0rpx rgba(0, 0, 0, 0.25); */
	  position: absolute;
	  width: 330rpx;
	  height: 330rpx;
	  top: 387rpx;
	  left: 402rpx;
	}
	
	.Basketball_Frame{
	opacity: 0.10000000149011612;
	border-radius: 20rpx;
	background: linear-gradient(109.28deg, #BADAF9 0%, #77BEFF 100%);
	box-shadow: 10rpx 10rpx 6rpx 0rpx #212529;
	
	position: absolute;
	width: 328rpx;
	height: 194rpx;
	left: 28rpx;
	top: 870rpx;
	}
	
	.group_buy{
	  position: absolute;
	  top: 768rpx;
	  width: 694rpx;
	  padding-left: 28rpx;
	  height: 50rpx;
	
	}
	
	.divider_buygroup{
	  border: 2rpx solid #E5E5E5;
	  width: 621rpx;
	  position: absolute;
	  top: 750rpx;
	  left: 70rpx;
	}
	
	.buy_img1{
	  width: 242rpx;
	  height: 40rpx;
	  padding-left: 42rpx;
	}
	
	.buy_img2{
	  height: 80rpx;
	  width: 80rpx;
	  bottom: -12rpx;
	  padding-left: 10rpx;
	  position: absolute;
	}
	
	.buy_img4{
	  height: 40rpx;
	  width: 60rpx;
	  bottom: 10rpx;
	  padding-left: 100rpx;
	  position: absolute;
	}
	
	.buy_img3{
	  width: 35rpx;
	  height: 35rpx;
	  position: absolute;
	  right: 34rpx;
	}
	
	.buy_text{
	  color: #000000;
	  font-family: Roboto;
	  font-weight: regular;
	  font-size: 24rpx;
	  line-height: normal;
	  letter-spacing: 0rpx;
	  text-align: left;
	  padding-left: 200rpx;
	  position: relative;
	  bottom: 15rpx;
	}
	
	.Medical_Frame{
	  opacity: 0.10000000149011612;
	  border-radius: 20rpx;
	  background: linear-gradient(109.28deg, #BADAF9 0%, #77BEFF 100%);
	  box-shadow: 10rpx 10rpx 6rpx 0rpx #212529;
	  
	  position: absolute;
	  width: 328rpx;
	  height: 194rpx;
	  left: 344rpx;
	  top: 870rpx;
	}
	
	.Coupons_Frame{
	  position: absolute;
	  left: 30rpx;
	  top: 1120rpx;
	  width: 486rpx;
	  height: 218rpx;
	  margin-bottom: 140rpx;
	
	border-radius: 40rpx 40rpx 40rpx 40rpx;
	background: linear-gradient(93.62deg, #2594fc 0%,rgba(247, 155, 193, 0) 70%, #fcc3d7 100%);
	box-shadow: 0rpx 2rpx 10rpx 0rpx #212529;
	
	}
	
	.basketball_title{
	  height: 40rpx;
	  position: absolute;
	  top: 906rpx;
	  left: 54rpx;
	
	color: #000000;
	text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	font-family: ZCOOL QingKe HuangYou;
	font-weight: regular;
	font-size: 35rpx;
	line-height: normal;
	letter-spacing: 0rpx;
	text-align: left;
	
	}
	
	.basketball_content{
	  position: absolute;
	  top: 980rpx;
	  left: 54rpx;
	
	  color: #8C8C8C;
	  text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	/* font-family: ZCOOL QingKe HuangYou; */
	font-weight: regular;
	font-size: 25rpx;
	line-height: normal;
	letter-spacing: 0rpx;
	text-align: left;
	}
	
	.bask_icon{
	  text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	 position: absolute;
	 left: 222rpx;
	 top: 906rpx;
	 width: 122rpx;
	 height: 122rpx;
	}
	
	.bask_line{
	  border: 2rpx solid #DFE4EA;
	  position: absolute;
	  width: 0rpx;
	  height: 138rpx;
	  top: 900rpx;
	  left: 214rpx;
	}
	
	.medicine_title{
	  height: 40rpx;
	  position: absolute;
	  top: 906rpx;
	  left: 412rpx;
	
	color: #000000;
	text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	font-family: ZCOOL QingKe HuangYou;
	font-weight: regular;
	font-size: 35rpx;
	line-height: normal;
	letter-spacing: 0rpx;
	text-align: left;
	
	}
	
	.medicine_content{
	  position: absolute;
	  top: 980rpx;
	  left: 412rpx;
	
	  color: #8C8C8C;
	  text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	/* font-family: ZCOOL QingKe HuangYou; */
	font-weight: regular;
	font-size: 25rpx;
	line-height: normal;
	letter-spacing: 0rpx;
	text-align: left;
	}
	
	.medicine_icon{
	  text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	 position: absolute;
	 right: 44rpx;
	 top: 906rpx;
	 width: 122rpx;
	 height: 122rpx;
	}
	
	.medicine_line{
	  border: 2rpx solid #DFE4EA;
	  position: absolute;
	  width: 0rpx;
	  height: 120rpx;
	  top: 876rpx;
	  left: 585rpx;
	}
	
	.my_Coupons_title{
	position: absolute;
	left: 80rpx;
	top: 1160rpx;
	color: #000000;
	text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	font-family: ZCOOL QingKe HuangYou;
	font-weight: regular;
	font-size: 40rpx;
	line-height: normal;
	letter-spacing: 0rpx;
	text-align: left;
	}
	
	.my_Coupons_num{
	position: absolute;
	left: 305rpx;
	top: 1160rpx;
	color: #000000;
	text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	font-family: ZCOOL QingKe HuangYou;
	font-weight: regular;
	font-size: 40rpx;
	line-height: normal;
	letter-spacing: 0rpx;
	text-align: left;
	}
	
	.my_Coupons_unit{
	  position: absolute;
	  left: 350rpx;
	  top: 1160rpx;
	  margin-left: 12rpx;
	  color: #000000;
	  text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
	  font-family: ZCOOL QingKe HuangYou;
	  font-weight: regular;
	  font-size: 40rpx;
	  line-height: normal;
	  letter-spacing: 0rpx;
	  text-align: left;
	}
	
	.my_Coupons_content{
	  color: #8C8C8C;
	  text-shadow: 0rpx 8rpx 8rpx 0rpx #000000;
	  font-family: ZCOOL QingKe HuangYou;
	  font-weight: regular;
	  font-size: 30rpx;
	  line-height: normal;
	  letter-spacing: 0rpx;
	  text-align: left;
	  position: absolute;
	  left: 80rpx;
	  top: 1210rpx;
	}
	
	.device{
	  position: absolute;
	  width: 180rpx;
	  height: 180rpx;
	  left: 550rpx;
	  top: 1100rpx;
	  display: flex;
	  flex-direction: column;
	  align-items: center;
	}
	
	.device text{
	  margin-top: 20rpx;
	}
	
	.my_Coupons_icon{
	position: absolute;
	right: 250rpx;
	top: 1200rpx;
	width: 201rpx;
	height: 116rpx;
	}
	
	/* ---------------------------- */
	/*模态框*/
	.modal{position:fixed; top:0; right:0; bottom:0; left:0; z-index:1000;}
	.modal-cancel{position:absolute; z-index:2000; top:0; right:0; bottom: 0; left:0; background:rgba(0,0,0,0.3);}
	.bottom-dialog-body{width:100%; position:absolute; z-index:3000; bottom:0; left:0;background:#dfdede;}
	/*动画前初始位置*/
	.bottom-positon{-webkit-transform:translateY(100%);transform:translateY(100%);}
	 
	/* 底部弹出框 */
	.bottom-positon{
	  text-align: center;
	}
</style>
