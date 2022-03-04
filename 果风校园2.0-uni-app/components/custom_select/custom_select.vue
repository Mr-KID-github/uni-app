<template>
	<view>
		<!-- 自定义选择器 -->
		<!-- 遮罩层 -->
		<view class="mask"  catchtouchmove='ture'></view> 
		
		<view class="Model">
			<view class="pickerBtn">
				<view class="cancer" @click="cancer">取消</view>
				<text class="item">选择您的配送安排</text>
				<view class="confirm" @click="confirm">确定</view>
			</view>
			<picker-view class="picker-view" @change="bindchange">
				<picker-view-column>
					<view class="item" v-for="(item,index) in times" :key="index">{{item}} times</view>
				</picker-view-column>
				<picker-view-column>
					<view class="item" v-for="(item,index) in days" :key="index">{{item}} days</view>
				</picker-view-column>
			</picker-view>
		</view>
	</view>
</template>

<script>
	export default {
		name:"custom_select",
		data() {
			const days=[]
			const times=[]
			for (let i = 1; i <= 31; i++) {
				days.push(i)
			}
			for (let i = 1; i <= 31; i++) {
				times.push(i)
			}
			return {
				days,
				times,
				showmask: true,
				day: 1,
				time: 1,
			};
		},
		props:['show'],
		created() {
			
		},
		methods:{
			bindchange(e){
				// console.log(e)
				this.time = e.detail.value[0] + 1
				this.day = e.detail.value[1] + 1
			},
			picker(e){
				this.mask = !this.mask 
			},
			cancer(){
				this.showmask = false
				uni.$emit('unshow',this.showmask)
				uni.$emit('custom_value',['自定义','自定义'])
			},
			confirm(){
				if (this.time > this.day) {
					uni.showModal({
						content:"一天最多一次配送",
						showCancel:false
					})
				} else {
					this.showmask = false
					uni.$emit('unshow',this.showmask)
					uni.$emit('custom_value',[this.day,this.time])
				}
			}
		}
	}
</script>

<style>
	.Model{
		width: 100%;
		position: fixed;
		bottom: 0rpx;
	}
	.pickerBtn {
		width: 680rpx;
		height: 101rpx;
		line-height: 101rpx;
		background-color: #fff;
		font-size: 40rpx;
		display: flex;
		justify-content: space-between;
		position: absolute;
		z-index: 1;
		border-radius: 40rpx 40rpx 0rpx 0rpx;
	}
	.cancer {
		color: #0076FF;
		padding-left: 40rpx;
		box-sizing: border-box;
		font-style: normal;
		font-weight: 600;
		font-size: 30rpx;
		line-height: 75rpx;
	}
	.confirm {
		color: #FE4533;
		padding-right: 40rpx;
		box-sizing: border-box;
		font-style: normal;
		font-weight: 600;
		font-size: 30rpx;
		line-height: 75rpx;
	}
	.picker-view {
	        width: 680rpx;
			height: 300rpx;
			margin-top: 60rpx;
			text-align: center;
			background-color: #f8f8f6;
	}
	.item{
		font-style: normal;
		font-weight: 600;
		font-size: 30rpx;
		line-height: 75rpx;
		
		color: #0A0909;
	}
	.select_title{
		font-style: normal;
		font-weight: 600;
		font-size: 30rpx;
		line-height: 75rpx;
		margin-right: 42rpx;
		
		color: #0A0909;
		
		background-color: white;
		width: 100%;
		z-index: 0;
		text-align: center;
	}
	.mask {
		position:absolute;
		top:0;
		left:0;
		margin-top: 0%;
		width: 100%;
		height:127vh;
	
		z-index: 0;
		background: rgba(0,0,0,0.5);
	}
	
</style>
