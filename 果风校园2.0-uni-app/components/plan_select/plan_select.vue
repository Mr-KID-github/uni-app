<template>
	<view>
		<view class="plan_bcg">
			<text class="plan_text">选择您要配送的果茶&果捞&水果方案</text>
			<view class="plan">
				<view class="item">
					<view :class="(plan_name=='方案一')?'item_name':'item_name2'" @click="select_plan" id="方案一">
						方案一
					</view>
					<text class="item_price">￥20.00</text>
				</view>
				<view class="item">
					<view :class="(plan_name=='方案二')?'item_name':'item_name2'" @click="select_plan" id="方案二">
						方案二
					</view>
					<text class="item_price">￥20.00</text>
				</view>
				<view class="item">
					<view :class="(plan_name=='自定义')?'item_name':'item_name2'" @click="select_plan" id="自定义">
						自定义
					</view>
					<text class="item_price">￥20.00</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				plan_name: '方案一'
			}
		},
		methods: {
			select_plan(e){
				// console.log(e.currentTarget.id)
				this.plan_name = e.currentTarget.id
				// 发送选择的方案给父组件
				this.$emit('send_plan',this.plan_name)
			}
		}
	}
</script>

<style>
.item{
	margin: 10rpx;
	display: flex;
	flex-direction: column;
	width: 190rpx;
	height: 165rpx;
}
.item_name{
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #2eb17f;
	border-radius: 25rpx;
	width: 190rpx;
	height: 120rpx;
	
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	/* identical to box height */
	
	text-align: center;
	
	color: #FFFFFF;
}
.item_name2{
	display: flex;
	justify-content: center;
	align-items: center;
	background-color: #FFFFFF;
	border-radius: 25rpx;
	width: 190rpx;
	height: 120rpx;
	
	font-style: normal;
	font-weight: bold;
	font-size: 36rpx;
	line-height: 46rpx;
	/* identical to box height */
	
	text-align: center;
	
	color: #000000;
}
.plan{
	display: flex;
}
.item_price{
	margin-top: 10rpx;
	font-style: normal;
	font-weight: bold;
	font-size: 28rpx;
	line-height: 36rpx;
	/* identical to box height */
	
	text-align: center;

	
	color: #000000;
}
.plan_bcg{
	display: flex;
	flex-direction: column;
	justify-content: center;
	align-items: center;
	background-color: #F1F4F7;
	width: 670rpx;
	height: 280rpx;
	border-radius: 20rpx;
	margin-top: 20rpx;
	padding-top: 24rpx;
}
.plan_text{
	position: relative;
	right: 45rpx;
	bottom: 10rpx;
	font-style: normal;
	font-weight: bold;
	font-size: 32rpx;
	line-height: 36rpx;
	/* identical to box height */
	
	color: #000000;
}
</style>
