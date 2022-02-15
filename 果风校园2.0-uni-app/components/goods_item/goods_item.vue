<template>
	<view>
		<view class="background">
			<view v-for="item in goods">
				<view class="good" v-if="item.goods_type==type">
					<view class="img_bcg">
						<image class="good_img" :src="item.goods_picture1"></image>
					</view>
					<view class="good_text">
						<text class="good_name">{{item.goods_name}}</text>
						<text class="good_price">¥{{item.goods_price}}</text>
					</view> 
					<image class="good_add" src="/static/img/Add.svg" v-if="item.goods_number!=0 && item.goods_cert==0" :id="item.goods_name" @click="add_num"></image>
					<image class="good_add" src="/static/img/No.svg" v-if="item.goods_number==0"></image>
					<view class="good_num" v-if="item.goods_cert != 0">
						<image src="/static/img/del.svg" class="num_img" @click="del_num" :id="item.goods_name"></image>
						<text class="num_text">{{ item.goods_cert }}</text>
						<image src="/static/img/add_num.svg" class="num_img" @click="add_num" :id="item.goods_name"></image>
					</view>
					<image class="no_sides" src="/static/img/no_sides.svg" v-if="item.goods_number==0"></image>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		name:"goods_item",
		data() {
			return {
				type: 'tea', 	//展示的商品类型
			};
		},
		created() {
			console.log("Created执行了")
			// 接收兄弟组件Goods_bar传来的参数商品类型,进行商品类型的筛选展示
			uni.$on('select_bar',(select)=>{
				console.log('接受到'  + select)
				this.type = select
			})
		},
		props:['goods'],	//接受父组件传递过来的商品信息
		methods: {
			  // 添加商品数量，原理同减少商品数量方法一样
			  add_num:function(e){
			    console.log(e.target.id)
			    for (let index = 0; index < this.goods.length; index++) {
			      const element = this.goods[index];
			      if (element.goods_name == e.target.id) {
			        //索引是动态的 则使用下方方式
					this.goods[index].goods_cert = this.goods[index].goods_cert + 1
			        // this.get_tatol_price()
					console.log(this.goods[index])
					// 子组件向父组件传值
					this.$emit("send_msg",this.goods[index].goods_cert,index)
			        break
			      }
			    }
			  },
			
			  // 减少商品数量
			  del_num:function(e){
			    console.log(e.target.id)
			    // 遍历商品表通过传入的商品名查找要操作的商品
			    for (let index = 0; index < this.goods.length; index++) {
			      const element = this.goods[index];
			      if (element.goods_name == e.target.id) {
			        //索引是动态的 则使用下方方式
					var real_num = this.goods[index].goods_cert - 1
			  //       // 当商品num为0时即移除购物车内该商品
			  //       if (real_num == 0) {
			  //         var that = this
			  //         // 移除商品时弹框询问用户是否确认移除
			  //         uni.showModal({
			  //           title:'移除商品',
			  //           content:'确认移除商品？',
			  //           showCancel:true,
			  //           // 用户点击确定就更新购物车内商品表
			  //           success(res){
					// 		console.log(res)
					// 		if (res.cancel) {
					// 			that.goods[index].goods_cert = 1
					// 		}
					// 		if (res.confirm) {
					// 			that.goods[index].goods_cert = 0
					// 		}
			  //             }
			  //         })
			  //       }
					// if (real_num){
					// 	this.goods[index].goods_cert = real_num
					// }
					this.goods[index].goods_cert = real_num
					// 子组件向父组件传值
					this.$emit("send_msg",this.goods[index].goods_cert,index)
			        break
			      }
			    }
			  },
		}
	}
</script>

<style>
.background{
	display: flex;
	flex-direction: column;
	align-items: center;
	margin-top: 10rpx;
}
.good_num{
	display: flex;
	height: 80rpx;
	width: 155rpx; 
	position: relative;
	right: 25rpx;
	justify-content: space-between;
	align-items: center;
}
.num_img{
	width: 60rpx;
	height: 60rpx;
}
.num_text{
	font-style: normal;
	font-weight: 800;
	font-size: 12px;
	line-height: 16px;
	text-align: center;
	letter-spacing: -0.393864px;
	
	color: #3C3C3C;
}
.good{
	width: 680rpx;
	height: 170rpx;
	margin-bottom: 30rpx;
	background-color: white;
	border-radius: 20rpx;
	display: flex;
	align-items: center;
	justify-content: space-between;
}
.good_add{
	height: 80rpx;
	width: 155rpx;
	position: relative;
	right: 25rpx;
}
.good_text{
	display: flex;
	flex-direction: column;
	justify-content: space-around;
	position: relative;
	right: 60rpx;
	font-style: normal;
	font-weight: 800;
	font-size: 13.799px;
	line-height: 19px;
	letter-spacing: 0.197129px;
	color: #3C3C3C;
}
.good_name{
	
}
.good_price{

}
.img_bcg{
	position: relative;
	left: 25rpx;
	display: flex;
	 justify-content: center; align-items: center; 
	 background-color: #7cc7d0; width: 110rpx; height: 110rpx;
	  border-radius: 30rpx;
}
.good_img{
	width: 95rpx;
	height: 95rpx;
	border-radius: 50rpx;
	background-color: #007AFF;
}
.no_sides{
	width: 120rpx;
	height: 40rpx;
	position: absolute;
	left:53rpx;
	margin-top: 100rpx;
}
</style>
