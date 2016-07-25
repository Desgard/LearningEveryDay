![](/background.png)

---


## 2016-07-24

### 从NSObject的初始化了解isa·笔记

原文链接：http://draveness.me/isa/

源码仓库：git@github.com:RetVal/objc-runtime.git

---

之前对于ObjC中对象的认识，**所有对象都包含一个类型的isa指针**，但是现在**使用版本的ObjC对象的结构已经不同，代替isa指针的结构体`isa_t`，这个结构体中包含了当前对象指向类的信息**。

```c
struct objc_object {
	isa_t isa;
};
```

当ObjC为一个对象分配内存，初始化实例变量后，在这些对象的实例变量中，第一个变量就是`isa`。

![](http://7xrlu3.com1.z0.glb.clouddn.com/2016-04-21-NSObject%20+%20NSObject%20Copy%20+%20@Draveness.png)

所有继承自`NSObject`的类实例化后的对象都会包含一个类型为`isa_t`的结构体。

从上图中可以看出，不只是*实例*会包含一个`isa`结构体，所有的*类*也会有这么一个`isa`。在ObjC中Class的电影以是一个名为`objc_class`的结构体。

```c
struct objc_class : objc_object {  
	// 从objc_object中继承了 isa_t isa 成员
    Class superclass;
    cache_t cache;
    class_data_bits_t bits;
};
```

由于`objc_class`结构体是继承自`objc_object`的，这里便显式地写出了`isa_t`这个成员变量。

## `isa`和metaclass

肯定的是：**Objective-C中的class也是一个对象**。

在ObjC中，对象的方法**不存在与存储对象的结构体中。**（如果每一个对象都保存自己执行的方法，会对内存有极大的占用。）当实例方法调用时候，通过自身持有的`isa`查找对应的类，在`class_data_bits_t`结构体中查找对应的方法。同时，每一个`objc_class`也有一个**指向父类指针**`super_class`，用来查找祖先方法。

![](http://7xrlu3.com1.z0.glb.clouddn.com/2016-04-21-Slice%201.png)

引入metaclass来保证无论是累还是对象都能**通过链式结构查找到方法**。

![](http://7xrlu3.com1.z0.glb.clouddn.com/2016-04-21-objc-isa-meta-class.png)

每一个类的`isa`指向对应的metaclass，这样可以做到类方法和实例方法消息机制方法的统一。

![](http://7xrlu3.com1.z0.glb.clouddn.com/2016-04-21-14611715787360.jpg)

## 结构体`isa_t`

源码中`isa_t`的数据结构

```c
#define ISA_MAGIC_MASK  0x001f800000000001ULL
#define ISA_MAGIC_VALUE 0x001d800000000001ULL
#define RC_ONE   (1ULL<<56)
#define RC_HALF  (1ULL<<7)

union isa_t {  
    isa_t() { }
    isa_t(uintptr_t value) : bits(value) { }

    Class cls;
    uintptr_t bits;

    struct {
        uintptr_t indexed           : 1;
        uintptr_t has_assoc         : 1;
        uintptr_t has_cxx_dtor      : 1;
        uintptr_t shiftcls          : 44;
        uintptr_t magic             : 6;
        uintptr_t weakly_referenced : 1;
        uintptr_t deallocating      : 1;
        uintptr_t has_sidetable_rc  : 1;
        uintptr_t extra_rc          : 8;
    };
};
```

平台是`__x86_64__`上的实现，而对于iPhone 5s等架构为`__arm64__`的设备上，具体结构的实现和卫士可能有些差别，不够这些字段都是存在的。

### isa_t具体细节

```c
union isa_t {  
    ...
};
```

`isa_t`是一个`union`（联合体）类型的结构体，所谓union就是多种数据共用一个空间。其作用对应如下：


变量名| 含义
--------- | -------------
indexed	| 0 表示普通的 isa 指针，1 表示使用优化，存储引用计数
has_assoc	|表示该对象是否包含 associated object，如果没有，则析构时会更快
has_cxx_dtor|	表示该对象是否有 C++ 或 ARC 的析构函数，如果没有，则析构时更快
shiftcls|	类的指针
magic|	固定值为 0xd2，用于在调试时分辨对象是否未完成初始化。
weakly_referenced|	表示该对象是否有过 weak 对象，如果没有，则析构时更快
deallocating|	表示该对象是否正在析构
has_sidetable_rc|	表示该对象的引用计数值是否过大无法存储在 isa 指针
extra_rc	|存储引用计数值减一后的结果

在64为环境下，`isa` 指针不一定惠存引用计数，19bit保存空间有局限性。这19位保存的是**引用计数减一**。如果`has_sidetable_rc`的值为1，引用计数会存储在`SlideTable`属性中。

### isa_t的初始化

```c
inline void 
objc_object::initInstanceIsa(Class cls, bool hasCxxDtor)
{
    assert(!UseGC);
    assert(!cls->requiresRawIsa());
    assert(hasCxxDtor == cls->hasCxxDtor());

    initIsa(cls, true, hasCxxDtor);
}

inline void 
objc_object::initIsa(Class cls, bool indexed, bool hasCxxDtor) 
{ 
    assert(!isTaggedPointer()); 
    
    if (!indexed) {
        isa.cls = cls;
    } else {
        assert(!DisableIndexedIsa);
        isa.bits = ISA_MAGIC_VALUE;
        // isa.magic is part of ISA_MAGIC_VALUE
        // isa.indexed is part of ISA_MAGIC_VALUE
        isa.has_cxx_dtor = hasCxxDtor;
        isa.shiftcls = (uintptr_t)cls >> 3;
    }
}
```

### `indexed`和`magic`

当对一个ObjC对象分配内存时，其方法调用了`indexed`和`magic`两个方法。`indexed = true`，`bits = 0x001d800000000001ULL`，转换成二进制发现有以下设置：

![](http://7xrlu3.com1.z0.glb.clouddn.com/2016-04-21-objc-isa-isat-bits.png)

我们发现只是设置了`indexed`和`magic`。也就是说，我们使用的isa指针通常情况下是优化isa（可保存引用计数的结构体`isa_t`，所以本身并不带有任何`class`的信息，都是存在结构体重的`shiftcls`中）， 而`magic`仅仅是一个初始化状态完成的flag（）。

个人计算后与小左的结论相同，magic的初值为`0x3b`。而[杨潇玉这篇文中和其引用的外国博文](http://yulingtianxia.com/blog/2015/12/06/The-Principle-of-Refenrence-Counting/)的magic初值对应不上。

### `has_cxx_dtor`

这个关键字是ARC中对象析构函数的析构器，没有则会快速释放内存。

### `shiftcls`

对类对象存入其信息。

```c
isa.shiftcls = (uintptr_t)cls >> 3;  
```

> 将当前地址右移三位的主要原因是用于将 Class 指针中无用的后三位（has_cxx_dtor, has_assoc, indexed）清楚减小内存的消耗，~~因为类的指针要按照字节（8 bits）对齐内存，其指针后三位都是没有意义的 0。~~

> ~~绝大多数机器的架构都是 byte-addressable 的，但是对象的内存地址必须对齐到字节的倍数，这样可以提高代码运行的性能，在 iPhone5s(arm64) 中虚拟地址为 33 位，所以用于对齐的最后三位比特为 000，我们只会用其中的 30 位来表示对象的地址。~~

也就是说，在struct中已经存储了isa_t中的部分信息，当isa_t初始化的时候，我们只需要从内存中按位获取即可。

### ISA()方法

看名字就能知道是返回isa指针的。源码：

```c
# elif __x86_64__
#   define ISA_MASK        0x00007ffffffffff8ULL

inline Class 
objc_object::ISA() 
{
    assert(!isTaggedPointer()); 
    return (Class)(isa.bits & ISA_MASK);
}
```

这个位运算还没有搞明白，里面的bits和index状态有关。

