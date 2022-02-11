<template>
	<view>
		<view class="frame">
		  <!-- 顶部信息条 -->
		  <text class="tag_title">冷饮售卖</text>
		  <text class="tag_content">快速下单，不用等！</text>
		  <image class="tag_icon" src="/static/img/Drink_icon.png"></image>
		  <image  class="tag_icon2" src="/static/img/cancel.png" @click="exit"></image>
		  <view class="divider"></view>
		
		  <!-- 框架 -->
		  <view class="item_frame">
		    <image src="/static/img/Drink_frame.png" class="frame_img"></image>
		  </view> 
		
		  <!-- 内容 -->
		  <text class="item_title">操作手册</text>
		  <!-- <text class="item_content1">1、点击下方'open',开柜门</text> -->
		  <text class="item_content1">1、点击'扫一扫'绑定设备</text>
		  <text class="item_content2">2、点击'open'，开柜门</text>
		  <text class="item_content3">3、关闭柜门，自动生成账单</text>
		  <text class="item_content4">4、点击前往支付进行支付</text>
		
		  <text class="item_num">库存：{{ device_inventory }}瓶</text>
		  <text class="item_price">单价：2元</text>
		  
		  <view class="open" @click="open_lock">
		    <image src="/static/img/open1.png" class="open_tap"></image>
		    <text class="open_text" v-if="device_id=='无'">扫一扫</text>
		    <text class="open_text" v-if="device_id!='无'">open</text>
		  </view>
		</view>
	</view>
</template>

<script>
	export default {
		name:"Componentdrink",
		data() {
			return {
				    unpaid: false,
				    device_id: '无',
				    device_inventory : 0
				    // unpaid_info: []
			};
		},
		methods:{
			exit(){
				console.log("点击exit")
				this.$emit("exit")
			},
			//open_lock方法：先查询用户有无登录
			//先查询全局中有无未支付的账单，如果有，直接跳转至open界面，弹出未支付的账单，如果没有，则调用开锁接口向云服务器发送开锁信息，并调用建立初始账单接口建立初始账单，再跳转至open界面
			open_lock:function(){
			      if (getApp().globalData.userInfo == null) {
			        wx.showModal({
			          title:'检测到您还未登录',
			          content:'点击确定跳转登录界面',
			          success(res){
			            if(res.confirm){
			              console.log('用户点击确定')
			              wx.reLaunch({
			                url: '/pages/auth/auth',
			              })
			            } else if (res.cancel) {
			              console.log('用户点击取消')
			            }
			          }
			        })
			      } else {
			        var that = this
			        //如果没有识别到设备id即去扫一扫
			        if (this.data.device_id=='无') {
			          //调用微信扫一扫功能扫描二维码识别装置
			          // 只允许从相机扫码
			          wx.scanCode({
			            onlyFromCamera: true,
			            success (res) {
			              // console.log(res)
			              // console.log(res.result)
			              if (res.result.search('device_id=')>=0) {
			                let device_id = res.result.replace(/[^\d]/g, "");     //利用正则表达式提取出二维码中的device_id
			                //给全局中的device_id赋值
			                getApp().globalData.device_id = device_id
			                wx.showModal({
			                  title:'绑定设备：'+device_id,
			                  content:'如果需要更换设备，请重新扫描',
			                  showCancel:false,
			                  success(res){
			                    if(res.confirm){
			                      wx.reLaunch({
			                        url: '/pages/Home/Home',
			                      })
			                    }
			                  }
			                })
			                wx.request({
			                  url: getApp().globalData.server + '/index.php/Home/QiuBao/Find_Device_inventory',
			                  data:{
			                    device_id: getApp().globalData.device_id, 
			                  },
			                  method:"POST",
			                  header: {
			                    'content-type': "application/x-www-form-urlencoded"
			                  },
			                  dataType: 'json',
			                  success:function(res){
			                    if(res.data.error_code != 0){
			                      // wx.showModal({
			                      //   title:'哎呀~',
			                      //   content:'出错了呢！' + res.data.msg,
			                      //   success(res){
			                      //     if(res.confirm){
			                      //       console.log('用户点击确定')
			                      //     }else if(res.cancel){
			                      //       console.log('用户点击取消')
			                      //     }
			                      //   }
			                      // })
			                    }else if(res.data.error_code == 0){
			                      // console.log(res.data.num)
			                      getApp().globalData.device_inventory = res.data.num
			                    }
			                  }
			                })
			              } else {
			                wx.showModal({
			                    title:'二维码有误',
			                    content:'请扫描正确的设备二维码',
			                    showCancel: false
			                  })
			              }
			            }
			          })
			        }else{
			          //与服务器交互---Find_Bill账单信息查找接口（半完成，没有联系用户id,计划在PHP端用post传输用户id），并把账单信息存储至全局变量中
			          console.log("查询服务器中有无未支付的账单")
			          wx.request({
			            url: getApp().globalData.server + '/index.php/Home/QiuBao/Find_Bill',
			            data:{},
			            method:"POST",
			            header: {
			              'content-type': 'application/json' // 默认值
			            },
			            success:function(res){
			              // console.log(res)
			              if(res.data.error_code != 0){
			                wx.showModal({
			                  title:'哎呀~',
			                  content:'出错了呢！' + res.data.msg,
			                  success(res){
			                    if(res.confirm){
			                      console.log('用户点击确定')
			                    }else if(res.cancel){
			                      console.log('用户点击取消')
			                    }
			                  }
			                })
			              }else if(res.data.error_code == 0){
			                // console.log(res.data.data)
			                for (let i = 0; i < res.data.data.length; i++) {
			                  if (res.data.data[i].bill_status=="未支付") {
			                    getApp().globalData.unpaid = true
			                    getApp().globalData.unpaid_info = res.data.data[i]
			                    break
			                  }
			                  getApp().globalData.unpaid = false
			                  getApp().globalData.unpaid_info = []
			                } 
			                console.log(getApp().globalData.unpaid)
			                console.log(getApp().globalData.unpaid_info)
			                // console.log(that.data.bill_info[0].coupon_price)
			              }
			            },
			            fail:function(res){
			              wx.showModal({
			                title:'哎呀~~',
			                content:'网络不在状态呢！',
			                success:function(res){
			                  if (res.confirm) {
			                    console.log("用户点击确定")
			                  } else if (res.cancel) {
			                    console.log("用户点击取消")
			                  }
			                }
			              })
			            },
			            complete:function(res){
			              wx.hideLoading({
			                success: (res) => {},
			              })
			            }
			          })
			  
			          setTimeout(function(){
			            wx.hideLoading({
			              success: (res) => {},
			            })
			          },2000)
			          //查询全局中有无未支付的账单，如果有，弹出未支付的账单
			          this.setData({
			            unpaid: getApp().globalData.unpaid,
			            // unpaid_info: getApp().globalData.unpaid_info
			          })
			          if (this.data.unpaid==true) {
			            console.log("发现有未支付订单，直接跳转至open")
			            wx.reLaunch({
			              url: '/pages/Open/Open',
			            })
			          } else {
			            // console.log(this.data.unpaid)
			            wx.request({
			              url: getApp().globalData.server + '/index.php/Home/QiuBao/Open_Device_lock',
			              data:{
			                device_id: getApp().globalData.device_id
			              },
			              method:"POST",
			              header: {
			                'content-type': "application/x-www-form-urlencoded"
			              },
			              dataType: 'json',
			              success:function(res){
			                // console.log(res)
			                if(res.data.error_code != 0){
			                  wx.showModal({
			                    title:'哎呀~',
			                    content:'出错了呢！' + res.data.msg,
			                    success(res){
			                      if(res.confirm){
			                        console.log('用户点击确定')
			                      }else if(res.cancel){
			                        console.log('用户点击取消')
			                      }
			                    }
			                  })
			                }else if(res.data.error_code == 0){
			                  console.log(res.data)
			                }
			              }
			            })
			            wx.request({
			              url: getApp().globalData.server + '/index.php/Home/QiuBao/Create_initial_order',
			              data:{
			                user_id: wx.getStorageSync('openId'), 
			                device_id: getApp().globalData.device_id
			              },
			              header: {
			                'content-type': "application/x-www-form-urlencoded"
			              },
			              method: 'POST',
			              dataType: 'json',
			              responseType: 'text',
			              success:function(res){
			                // console.log(res)
			              if(res.data.error_code != 0){
			                wx.showModal({
			                  title:'哎呀~',
			                  content:'出错了呢！' + res.data.msg,
			                  success(res){
			                    if(res.confirm){
			                      console.log('用户点击确定')
			                    }else if(res.cancel){
			                      console.log('用户点击取消')
			                    }
			                  }
			                })
			              }else if(res.data.error_code == 0){
			                console.log(res.data)
			              }
			              }
			            })
			            console.log("开锁跳转至open")
			            wx.reLaunch({
			              url: '/pages/Open/Open',
			            })
			          }
			        }
			      }
			    }
		}
	}
</script>

<style>

.frame{
  position: absolute;
  bottom: 0rpx;
  border-radius: 70rpx 70rpx 0rpx 0rpx;
  background: #FFFFFF;
  width: 750rpx;
  height: 1166rpx;
  z-index: 1000;
}

.tag_title{
  position: absolute;
  left: 252rpx;
  top: 62rpx;
  color: #000000;
  text-shadow: 0px 8rpx 8rpx rgba(0, 0, 0, 0.25);
  font-family: ZCOOL QingKe HuangYou;
  font-weight: regular;
  font-size: 40rpx;
  line-height: normal;
  letter-spacing: 0rpx;
  text-align: left;
}
  
  .tag_content{
    color: #8C8C8C;
    text-shadow: 0rpx 8rpx 8rpx 0rpx #000000;
    font-family: ZCOOL QingKe HuangYou;
    font-weight: regular;
    font-size: 26rpx;
    line-height: normal;
    letter-spacing: 0rpx;
    text-align: left;
    position: absolute;
    left: 282rpx;
    top: 122rpx;
  
  }
  
  .tag_icon{
  position: absolute;
  width: 142rpx;
  height: 142rpx;
  right: 518rpx;
  top: 38rpx;
  }

  .tag_icon2{
    position: absolute;
    top: 24rpx;
    left:664rpx;

    width: 54rpx;
    height: 52rpx;
  }

  .divider{
    border-radius: 18rpx;
border: 2rpx solid #DFE4EA;
box-shadow: 0rpx 8rpx 8rpx 0rpx #000000;
    position: absolute;
    width: 634rpx;
    height: 0rpx;
    left: 58rpx;
    top: 188rpx;
    margin-bottom: 40rpx;
  }

.frame_img{
position: absolute;
width: 660rpx;
height: 780rpx;
left: 38rpx;
top: 250rpx;
}

.item_title{

    height: 40rpx;
    position: absolute;
    top: 250rpx;
    left: 416rpx;

    color: #000000;
font-family: ZCOOL KuaiLe;
font-weight: regular;
font-size: 40rpx;
line-height: normal;
letter-spacing: 0rpx;
text-align: left;

}

.item_content1{
  left: 155rpx;
  top: 330rpx;

  height: 40rpx;
  position: absolute;

  color: #000000;
font-family: ZCOOL KuaiLe;
font-weight: regular;
font-size: 40rpx;
line-height: normal;
letter-spacing: 0rpx;
text-align: left;
}

.item_content2{
  left: 100rpx;
  top: 410rpx;

  height: 40rpx;
  position: absolute;

  color: #000000;
font-family: ZCOOL KuaiLe;
font-weight: regular;
font-size: 40rpx;
line-height: normal;
letter-spacing: 0rpx;
text-align: left;
}

.item_content3{
  left: 60rpx;
  top: 490rpx;

  height: 40rpx;
  position: absolute;

  color: #000000;
font-family: ZCOOL KuaiLe;
font-weight: regular;
font-size: 40rpx;
line-height: normal;
letter-spacing: 0rpx;
text-align: left;
}

.item_content4{
  left: 88rpx;
  top: 570rpx;

  height: 40rpx;
  position: absolute;

  color: #000000;
font-family: ZCOOL KuaiLe;
font-weight: regular;
font-size: 40rpx;
line-height: normal;
letter-spacing: 0rpx;
text-align: left;
}

.item_num{
  position: absolute;
  left: 206rpx;
  top: 650rpx;
  color: #FFFFFF;
font-family: ZCOOL KuaiLe;
font-weight: regular;
font-size: 40rpx;
line-height: normal;
letter-spacing: 0rpx;
text-align: left;

}

.item_price{
  position: absolute;
  left: 320rpx;
  top: 720rpx;
  color: #FFFFFF;
font-family: ZCOOL KuaiLe;
font-weight: regular;
font-size: 40rpx;
line-height: normal;
letter-spacing: 0rpx;
text-align: left;
}

.large_buy{
  position: absolute;
  bottom: 14rpx;
  left: 8rpx;
display: flex;
justify-content: center;
align-items: center;
}

.buy_img{
  width: 124rpx;
  height: 124rpx;
}

.buy_text{
  color: #000000;
  font-family: ZCOOL KuaiLe;
  font-weight: regular;
  font-size: 30rpx;
  display: flex;
  align-items: center;
  line-height: normal;
  letter-spacing: 0rpx;
  text-align: center;
  width: 74rpx;
  height: 80rpx;  
  position: absolute;

}

.open{

position: absolute;
top: 932rpx;
left: 416rpx;  
display: flex;
justify-content: center;
align-items: center;
}

.open_text{
color: #000000;
font-family: Ink Free;
font-weight: regular;
font-size: 45rpx;
line-height: normal;
letter-spacing: 0rpx;
text-align: left;
position: absolute;
padding-bottom: 30rpx;
padding-right: 30rpx;
}


.open_tap{
  width: 284rpx;
  height: 96rpx;
}
</style>
