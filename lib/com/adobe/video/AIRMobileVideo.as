﻿package com.adobe.video{	import flash.desktop.NativeApplication;	import flash.desktop.SystemIdleMode;	import flash.display.Stage;	import flash.display.StageAlign;	import flash.display.StageScaleMode;	import flash.events.Event;	import flash.events.StageVideoAvailabilityEvent;	import flash.geom.Rectangle;	import flash.media.StageVideo;	import flash.media.Video;	import flash.media.StageVideoAvailability;	import flash.net.NetConnection;	import flash.net.NetStream;
		public dynamic class AIRMobileVideo	{		protected var stream:NetStream;		protected var stageVideo:StageVideo;		protected var softwareVideo:Video;		 		public function AIRMobileVideo(stage:Stage)		{			var nc:NetConnection = new NetConnection();			nc.connect(null);			stream = new NetStream(nc);			stream.client = this ;						// may need to check using the StageVideoAvailability event, but this seems to work			if (stage.stageVideos.length > 0)			{				stageVideo = stage.stageVideos[0];			}						if (stageVideo)			{				stageVideo.viewPort = new Rectangle(0, 240, 640, 480);				trace("AIRMobileVideo: using stage video");			}			else			{				// software fallback				softwareVideo = new Video(640, 480);				softwareVideo.y = 240;				stage.addChild(softwareVideo);								trace("AIRMobileVideo: using software fallback");			}		}				public function playVideo(url:String):void		{			stream.close();						if (stageVideo)			{				stageVideo.attachNetStream(stream);			}			else			{				softwareVideo.attachNetStream(stream);			}			stream.play(url);		}		public function stopVideo():void		{			stream.close();			stageVideo = null;		}				public function onMetaData( info:Object ):void 		{					}				private function handleActivate(event:Event):void		{			NativeApplication.nativeApplication.systemIdleMode = SystemIdleMode.KEEP_AWAKE;		}				private function handleDeactivate(event:Event):void		{			NativeApplication.nativeApplication.exit();		}				}} 	