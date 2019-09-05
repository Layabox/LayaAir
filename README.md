# LayaAir is an open-source 2D/3D engine

LayaAir use WebGL1.0/WebGL2.0 as graphic API and written by TypeScript.
LayaAir is designed for high performance games and support TypeScript, JavaScript and ActionScript 3.0 programming language.
Develop once and publish for multi-target platform (HTML5, Android, iOS, Wechat Mini-Game, Facebook Instant Game).

## LayaAir features

- High performance

LayaAir use GPU graphic API(WebGL1.0/WebGL2.0).
LayaAir is design to performance first.

- Lightweight and easy to use

Except performance,LayaAir architecture aim to be simple and easy to use, openness and small size. It's a 2D/3D engine can run very well for HTML5 platform.

- Multi language development support

Build your HTML5 application from ActionScript 3, TypeScript and JavaScript project.

- Multi-target platform support

LayaAir can directly build HTML5 and Wechat Mini-Game platform. Extend native platform app with LayaNative, a complete development solution for LayaAir engine to target native Apps, such as iOS or Android. LayaNative uses LayaPlayer as the core runtime and uses reflection function to provide developers with a secondary development. You also can use this function to handle docking market on your native applications. And it also provides developers with testApp and build tools to package and publish your project.

- Mature ecosystem for design development and tool flow

[LayaAirIDE](https://ldc2.layabox.com/layadownload/?type=layaairide-LayaAir) Offer 2D development tools and visual editor. Clear workflow make, ergonomic, designed development efficiency.Support code development,UI and Scene Editor,Particle Editor,Animation Editor,Physical Editor,Presupposition,Build Platform Packaging,Code confusion, compression and so on.

[Unity Plugin](https://ldc2.layabox.com/layadownload/?type=layaairide-LayaAir) Offer 3D resource and scene editor and export with Unity, Compatibility support for commonly used unity funtion such as : Animtor,MeshRender,MeshFilter,ParticleSystem,Light,TrailRender,Lightingmap,Physics. Can let Unity project easier migration to LayaAir or directly use Unity as the 3D Editor.

- Open-source and free

Our official Layabox Github with complete engine source version, free of charge, including commercial usage.

## general features overview

- 2D

  Vector Renderer, Atlas Texture, Load Manager, HTML Text, Bitmap Fonts, Mask, Filter, Animation, Timeline, UI, ParticleSystem, SkeletonAnimation, Physics, etc..
  
- 3D

  Camera, Mesh, ParticleSystem, Multiple Light, SkyRender ,Animation , PhysicBaseRendering, Shadow, Custom Shader, Trail effect, PixelLine, Physics, Fog, StaticBatch, DynamicBatch, PostProcess etc...

## Beginner usage

#### JS version

```js
    Laya.init(550, 400);
    Laya.stage.scaleMode = "showall";

    var ape = new Laya.Sprite();
    //Loading our monkey
    ape.loadImage("res/apes/monkey2.png");

    Laya.stage.addChild(ape);
```

#### AS version

```as3
    package
    {
        import laya.display.Sprite;
        import laya.display.Stage;

        public class Sprite_DisplayImage
        {
            public function Sprite_DisplayImage()
            {
                Laya.init(550, 400);
      		    Laya.stage.scaleMode = "showall";

                var ape:Sprite = new Sprite();
                //Loading our monkey
                ape.loadImage("res/apes/monkey2.png");

                Laya.stage.addChild(ape);
            }
        }
    }
```

#### TS version

```ts
    /// <reference path="../../libs/LayaAir.d.ts" />
    class Sprite_DisplayImage{

        constructor(){
            Laya.init(550, 400);
            Laya.stage.scaleMode = "showall";

            var ape = new Laya.Sprite();
            //Loading our monkey
            ape.loadImage("res/apes/monkey2.png");

            Laya.stage.addChild(ape);
        }
    }
    new Sprite_DisplayImage();
```

## API Document

- https://layaair.ldc.layabox.com/api2

## Tutorial Document

- https://ldc2.layabox.com/doc/?nav=zh-ts-0-3-0

## Samples Demo

- https://layaair2.ldc2.layabox.com/demo2/

## Business Case 

- https://www.layabox.com/gamelist/

## Offical Community

- http://ask.layabox.com/
