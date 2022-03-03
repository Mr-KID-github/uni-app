<template>
	<view>
		<!-- 导入方案选择组件 -->
		<plan_select @send_plan="get_plan"></plan_select>
		<view class="plan_goods" v-if="plan_name!='自定义'">
			<text class="plan_goods_title">科学-搭配</text>
			<!-- 导入计划商品组件 -->
			<view v-for="item in plan_item">
				<plan_good v-if="item.plan_name==plan_name" :important='item.plan_important' :price="item.plan_price" :plan_introduct="item.plan_introduct" :good_name="item.plan_good" :img_url="item.plan_img"></plan_good>
			</view>
		</view>
		<view class="plan_goods" v-if="plan_name=='自定义'">
			<text class="plan_goods_title">自选-搭配</text>
			<!-- 导入计划商品组件 -->
			<view @click="to_shop" id="fruit">
				<plan_good price="0" img_url="/static/img/fruit1.jpg" plan_introduct="选择您想要配送的水果" good_name="自选水果通道" arrow=true></plan_good>
			</view>
			<view @click="to_shop" id="fishing">
				<plan_good price="0" img_url="/static/img/fishing2.jpg" plan_introduct="选择您想要配送的果捞" good_name="自选果捞通道" arrow=true></plan_good>
			</view>
			<view @click="to_shop" id="tea">
				<plan_good price="0" img_url="/static/img/tea5.jpg" plan_introduct="选择您想要配送的果茶" good_name="自选果茶通道" arrow=true></plan_good>
			</view>
		</view>
		<view class="plan_time">
			<text class="plan_title">配送次数 & 配送周期</text>
			<view class="time_content">
				<view class="time_item" v-if="plan_name!='自定义'">
					<image src="/static/img/times.svg"></image>
					<text>{{plan_name=='方案一'?plan1_settings.settings_times:plan2_settings.settings_times}}</text>
					<text>times</text>
				</view>
				
				<!-- 点击展示自定义弹窗 -->
				<view class="time_item" @click="show_Model" v-if="plan_name=='自定义'">
					<image src="/static/img/times.svg"></image>
					<text v-if="custom_settings.settings_times">{{custom_settings.settings_times}}</text>
					<view v-if="!custom_settings.settings_times" id="times_input">{{!custom_settings.settings_times?'自定义':custom_settings.settings_times}}</view>
					<text>times</text>
				</view>
				
				<view class="time_item" v-if="plan_name!='自定义'">
					<image src="/static/img/days.svg"></image>
					<text>{{plan_name=='方案一'?plan1_settings.settings_days:plan2_settings.settings_days}}</text>
					<text>days</text>
				</view>
				
				<!-- 点击展示自定义弹窗 -->
				<view class="time_item" @click="show_Model" v-if="plan_name=='自定义'" >
					<image src="/static/img/days.svg"></image>
					<text v-if="custom_settings.settings_days">{{custom_settings.settings_days}}</text>
					<view id="days_input" v-if="!custom_settings.settings_days">{{!custom_settings.settings_days?'自定义':custom_settings.settings_days}}</view>
					<text>days</text>
				</view>
			</view>
		</view>
		<view class="Notification">
			<text class="plan_title">
				配送时间
			</text>
			<view style="display: flex; align-items: center;">
				<view class="Notification_item">
					<image src="/static/img/Notification.svg"></image>
					<text>15:00PM - 18:00PM</text>
				</view>
				<text class="Notification_Check_text">是否-提醒</text>
				<image src="/static/img/Notification_Check.svg" class="Notification_img"  v-if="Notification_Check" @click="change_Check"></image>
				<image src="/static/img/Notification_UnCheck.svg" class="Notification_img" v-if="!Notification_Check" @click="change_Check"></image>
			</view>
		</view>
		<view class="Total">
			<text class="Total_price">Total:￥{{plan_name=='方案一'?plan1_price:(plan_name=='方案二'?plan2_price:custom_price)}}</text>
			<text class="Total_extend">选择定制配送套餐，每周赠送一杯果茶</text>
		</view>
	
		<view class="button">
			<image src="/static/img/REVIEW_MENU.svg"></image>
			<image src="/static/img/CHECK_OUT.svg" @click="check_out"></image>
		</view>
		
		
		<!-- 自定义弹窗 -->
		<view v-if="show_select">
			<custom_select></custom_select>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				Notification_Check: true,
				plan_name: '方案一',
				plan_item: [],
				plan1_settings: {},
				plan2_settings: {},
				custom_settings:{},
				plan1_price: 0,
				plan2_price:0,
				custom_price:0,
				
				show_select:false, 		// 是否展示自定义弹窗
			}
		},
		onLoad() {
			// 接受子组件传递过来的是否展示自定义弹窗的数据
			uni.$on('unshow',(show)=>{
				console.log('接受是否展示'  + show)
				this.show_select = show
			})
			uni.$on('custom_value',(value)=>{
				console.log('接受是否展示'  + value)
				// 将自定义方案的设置更新到本地
				this.custom_settings.settings_times = value[1]
				this.custom_settings.settings_days = value[0]
			})
			// 获取方案数据
			var that = this
			uni.request({
				url: getApp().globalData.server + '/index.php/Home/GuoFeng/findplan',
				data:{
					
				},
				method:"POST",
				header: {
					'content-type': "application/x-www-form-urlencoded"
				},
				dataType: 'json',
				success:function(res){
					console.log("成功获取到方案信息") 
					// console.log(res.data.data)
					console.log(res.data.setting)
					that.plan_item = res.data.data
					for (let i = 0 ; i<res.data.setting.length; i++ ){
						var item = res.data.setting[i]
						if (item.settings_by == "方案一") {
							that.plan1_settings = item
						} else if (item.settings_by == "方案二") {
							that.plan2_settings = item
						} else if (item.settings_by == getApp().globalData.openid) {
							that.custom_settings = item
						}
					}
					for (let i = 0 ; i<res.data.data.length; i++ ){
						var item = res.data.data[i]
						if (item.plan_name == "方案一") {
							that.plan1_price = parseInt(item.plan_price) + that.plan1_price
						} else if (item.plan_name == "方案二") {
							that.plan2_price = parseInt(item.plan_price) + that.plan2_price
						} else if (item.plan_name == getApp().globalData.openid) {
							that.custom_price = parseInt(item.plan_price) + that.custom_price
						}
					}
					console.log(that.plan2_price)
				}
			})
		},
		methods: {
			//展示自定义弹窗
			show_Model(){
				this.show_select = true
			},
			check_out(){
				console.log("确认" + this.plan_name)
				getApp().globalData.select_plan = this.plan_name
				uni.navigateTo({
					url: '/pages/Custom_goods/Custom_goods'
				})
			},
			change_Check(){
				this.Notification_Check = !this.Notification_Check
			},
			// 接受从子组件方案选择器里传入的方案
			get_plan(plan_name){
				// console.log(plan_name)
				this.plan_name = plan_name
			},
		}
	}
</script>

<style>
	
page{
	background-color: #ffffff;
	display: flex;
	flex-direction: column;
	align-items: center;
}
.custom_text{
	width: 510rpx;
	height: 92rpx;
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	text-align: center;
	
	color: #000000;
}
.plan_goods{
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	background-color: #F1F4F7;
	width: 670rpx;
	height: 500rpx;
	border-radius: 20rpx;
	margin-top: 20rpx;
}

.plan_goods_title{
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	position: relative;
	right: 210rpx;
	color: #000000;
}

.plan_time{
	width: 670rpx;
}
.plan_title{
	font-style: normal;
	font-weight: 600;
	font-size: 30rpx;
	line-height: 76rpx;
	
	color: #0A0909;
}

.time_content{
	display: flex;
	justify-content: space-between;
}

.time_item{
	width: 320rpx;
	height: 95rpx;
	background-color: #f8f8f6;
	border-radius: 20rpx;
	display: flex;
	align-items: center;
}
.time_item image{
	width: 42rpx;
	height: 42rpx;
	margin-left: 30rpx;
	margin-right: 30rpx;
}

.time_item text{
	font-style: normal;
	font-weight: 600;
	font-size: 30rpx;
	line-height: 75rpx;
	margin-right: 42rpx;
	
	color: #0A0909;
}

.time_item view{
	font-style: normal;
	font-weight: 600;
	font-size: 28rpx;
	margin-right: 18rpx;
	
	color: #0A0909;
}

.Notification_item{
	width: 350rpx;
	height: 85rpx;
	background-color: #f8f8f6;
	border-radius: 20rpx;
	display: flex;
	align-items: center;
}
.Notification_item image{
	width: 40rpx;
	height: 40rpx;
	margin-left: 30rpx;
}
.Notification_item text{
	font-style: normal;
	font-weight: 800;
	font-size: 25rpx;
	line-height: 25rpx;
	margin-left: 20rpx;
	color: #0A0909;
}
.Notification_item input{
	width: 160rpx;
	font-style: normal;
	font-weight: 600;
	font-size: 34rpx;
	line-height: 75rpx;
	margin-left: 30rpx;
	color: #0A0909;
}
.Notification_img{
	width: 96rpx;
	height: 96rpx;
}
.Notification_Check_text{
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	margin-left: 30rpx;
	margin-right: 22rpx;
	color: #000000;
}
.Total_price{
	font-style: normal;
	font-weight: bold;
	font-size: 50rpx;
	line-height: 60rpx;
	
	color: #000000;
}
.Total{
	margin-top: 40rpx;
	display: flex;
	flex-direction: column;
}
.Total_extend{
	font-style: normal;
	font-weight: normal;
	font-size: 28rpx;
	line-height: 36rpx;
	color: #000000;

}

.button{
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 40rpx;
	margin-bottom: 50rpx;
}

.button image{
	width: 330rpx;
	height: 100rpx;
	margin-right: 10rpx;
}


</style>
