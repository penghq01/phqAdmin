####Column属性定义

<table>
    <tbody><tr>
        <td>name</td><td>当前field对应的字段的名称，可选，如不写，则自动根据field名字和转换规则命名，如与其它关键字冲突，请使用单引号括起来。</td>
    </tr>
    <tr>
        <td>pk</td><td>是否是Primary Key，如果在一个struct中有多个字段都使用了此标记，则这多个字段构成了复合主键，单主键当前支持int32,int,int64,uint32,uint,uint64,string这7种Go的数据类型，复合主键支持这7种Go的数据类型的组合。</td>
    </tr>
    <tr>
        <td>当前支持30多种字段类型，详情参见本文最后一个表格</td><td>字段类型</td>
    </tr>
    <tr>
        <td>autoincr</td><td>是否是自增</td>
    </tr>
    <tr>
        <td>[not ]null 或 notnull</td><td>是否可以为空</td>
    </tr>
    <tr>
        <td>unique或unique(uniquename)</td><td>是否是唯一，如不加括号则该字段不允许重复；如加上括号，则括号中为联合唯一索引的名字，此时如果有另外一个或多个字段和本unique的uniquename相同，则这些uniquename相同的字段组成联合唯一索引</td>
    </tr>
    <tr>
        <td>index或index(indexname)</td><td>是否是索引，如不加括号则该字段自身为索引，如加上括号，则括号中为联合索引的名字，此时如果有另外一个或多个字段和本index的indexname相同，则这些indexname相同的字段组成联合索引</td>
    </tr>
    <tr>
        <td>extends</td><td>应用于一个匿名成员结构体或者非匿名成员结构体之上，表示此结构体的所有成员也映射到数据库中，extends可加载无限级</td>
    </tr>
    <tr>
        <td>-</td><td>这个Field将不进行字段映射</td>
    </tr>
     <tr>
        <td>-&gt;</td><td>这个Field将只写入到数据库而不从数据库读取</td>
    </tr>
     <tr>
        <td>&lt;-</td><td>这个Field将只从数据库读取，而不写入到数据库</td>
    </tr>
     <tr>
        <td>created</td><td>这个Field将在Insert时自动赋值为当前时间</td>
    </tr>
     <tr>
        <td>updated</td><td>这个Field将在Insert或Update时自动赋值为当前时间</td>
    </tr>
    <tr>
        <td>deleted</td><td>这个Field将在Delete时设置为当前时间，并且当前记录不删除</td>
    </tr>
     <tr>
        <td>version</td><td>这个Field将会在insert时默认为1，每次更新自动加1</td>
    </tr>
    <tr>
        <td>default 0或default(0)</td><td>设置默认值，紧跟的内容如果是Varchar等需要加上单引号</td>
    </tr>
    <tr>
        <td>json</td><td>表示内容将先转成Json格式，然后存储到数据库中，数据库中的字段类型可以为Text或者二进制</td>
    </tr>
</tbody></table>

####xorm类型和各个数据库类型的对应表

<table>
    <tbody>
    <tr>
    <td>xorm
    </td>
    <td>mysql
    </td>
    <td>sqlite3
    </td>
    <td>postgres
    </td>
    <td>remark</td>
    </tr>
    <tr>
    <td>BIT
    </td>
    <td>BIT
    </td>
    <td>INTEGER
    </td>
    <td>BIT
    </td>
    <td></td>
    </tr>
    <tr>
    <td>TINYINT
    </td>
    <td>TINYINT
    </td>
    <td>INTEGER
    </td>
    <td>SMALLINT
    </td>
    <td></td>
    </tr>
<tr>
    <td>SMALLINT
    </td>
    <td>SMALLINT
    </td>
    <td>INTEGER
    </td>
    <td>SMALLINT
    </td>
    <td></td>
    </tr>
<tr>
    <td>MEDIUMINT
    </td>
    <td>MEDIUMINT
    </td>
    <td>INTEGER
    </td>
    <td>INTEGER
    </td>
    <td></td>
    </tr>
<tr>
    <td>INT
    </td>
    <td>INT
    </td>
    <td>INTEGER
    </td>
    <td>INTEGER
    </td>
    <td></td>
    </tr>
<tr>
    <td>INTEGER
    </td>
    <td>INTEGER
    </td>
    <td>INTEGER
    </td>
    <td>INTEGER
    </td>
    <td></td>
    </tr>
<tr>
    <td>BIGINT
    </td>
    <td>BIGINT
    </td>
    <td>INTEGER
    </td>
    <td>BIGINT
    </td>
    <td></td>
    </tr>
 <tr><td cols="5"></td></tr>
<tr>
    <td>CHAR
    </td>
    <td>CHAR
    </td>
    <td>TEXT
    </td>
    <td>CHAR
    </td>
    <td></td>
    </tr>


<tr>
    <td>VARCHAR
    </td>
    <td>VARCHAR
    </td>
    <td>TEXT
    </td>
    <td>VARCHAR
    </td>
    <td></td>
    </tr>


<tr>
    <td>TINYTEXT
    </td>
    <td>TINYTEXT
    </td>
    <td>TEXT
    </td>
    <td>TEXT
    </td>
    <td></td>
    </tr>

<tr>
    <td>TEXT
    </td>
    <td>TEXT
    </td>
    <td>TEXT
    </td>
    <td>TEXT
    </td>
    <td></td>
    </tr>

<tr>
    <td>MEDIUMTEXT
    </td>
    <td>MEDIUMTEXT
    </td>
    <td>TEXT
    </td>
    <td>TEXT
    </td>
    <td></td>
    </tr>


<tr>
    <td>LONGTEXT
    </td>
    <td>LONGTEXT
    </td>
    <td>TEXT
    </td>
    <td>TEXT
    </td>
    <td></td>
    </tr>
<tr><td cols="5"></td></tr>

<tr>
    <td>BINARY
    </td>
    <td>BINARY
    </td>
    <td>BLOB
    </td>
    <td>BYTEA
    </td>
    <td></td>
    </tr>


<tr>
    <td>VARBINARY
    </td>
    <td>VARBINARY
    </td>
    <td>BLOB
    </td>
    <td>BYTEA
    </td>
    <td></td>
    </tr>
<tr><td cols="5"></td></tr>

<tr>
    <td>DATE
    </td>
    <td>DATE
    </td>
    <td>NUMERIC
    </td>
    <td>DATE
    </td>
    <td></td>
    </tr>


<tr>
    <td>DATETIME
    </td>
    <td>DATETIME
    </td>
    <td>NUMERIC
    </td>
    <td>TIMESTAMP
    </td>
    <td></td>
    </tr>


<tr>
    <td>TIME
    </td>
    <td>TIME
    </td>
    <td>NUMERIC
    </td>
    <td>TIME
    </td>
    <td></td>
    </tr>


<tr>
    <td>TIMESTAMP
    </td>
    <td>TIMESTAMP
    </td>
    <td>NUMERIC
    </td>
    <td>TIMESTAMP
    </td>
    <td></td>
    </tr>


<tr>
    <td>TIMESTAMPZ
    </td>
    <td>TEXT
    </td>
    <td>TEXT
    </td>
    <td>TIMESTAMP with zone
    </td>
    <td>timestamp with zone info</td>
    </tr>

<tr><td cols="5"></td></tr>
<tr>
    <td>REAL
    </td>
    <td>REAL
    </td>
    <td>REAL
    </td>
    <td>REAL
    </td>
    <td></td>
    </tr>


<tr>
    <td>FLOAT
    </td>
    <td>FLOAT
    </td>
    <td>REAL
    </td>
    <td>REAL
    </td>
    <td></td>
    </tr>


<tr>
    <td>DOUBLE
    </td>
    <td>DOUBLE
    </td>
    <td>REAL
    </td>
    <td>DOUBLE PRECISION
    </td>
    <td></td>
    </tr>

<tr><td cols="5"></td></tr>
<tr>
    <td>DECIMAL
    </td>
    <td>DECIMAL
    </td>
    <td>NUMERIC
    </td>
    <td>DECIMAL
    </td>
    <td></td>
    </tr>


<tr>
    <td>NUMERIC
    </td>
    <td>NUMERIC
    </td>
    <td>NUMERIC
    </td>
    <td>NUMERIC
    </td>
    <td></td>
    </tr>

<tr><td cols="5"></td></tr>
<tr>
    <td>TINYBLOB
    </td>
    <td>TINYBLOB
    </td>
    <td>BLOB
    </td>
    <td>BYTEA
    </td>
    <td></td>
    </tr>


<tr>
    <td>BLOB
    </td>
    <td>BLOB
    </td>
    <td>BLOB
    </td>
    <td>BYTEA
    </td>
    <td></td>
    </tr>


<tr>
    <td>MEDIUMBLOB
    </td>
    <td>MEDIUMBLOB
    </td>
    <td>BLOB
    </td>
    <td>BYTEA
    </td>
    <td></td>
    </tr>


<tr>
    <td>LONGBLOB
    </td>
    <td>LONGBLOB
    </td>
    <td>BLOB
    </td>
    <td>BYTEA
    </td>
    <td></td>
    </tr>

<tr>
    <td>BYTEA
    </td>
    <td>BLOB
    </td>
    <td>BLOB
    </td>
    <td>BYTEA
    </td>
    <td></td>
    </tr>

<tr><td cols="5"></td></tr>

<tr>
    <td>BOOL
    </td>
    <td>TINYINT
    </td>
    <td>INTEGER
    </td>
    <td>BOOLEAN
    </td>
    <td></td>
    </tr>


<tr>
    <td>SERIAL
    </td>
    <td>INT
    </td>
    <td>INTEGER
    </td>
    <td>SERIAL
    </td>
    <td>auto increment</td>
</tr>
<tr>
    <td>BIGSERIAL
    </td>
    <td>BIGINT
    </td>
    <td>INTEGER
    </td>
    <td>BIGSERIAL
    </td>
    <td>auto increment</td>
    </tr>
</tbody>
</table>

####Go与字段类型对应表
如果不使用tag来定义field对应的数据库字段类型，那么系统会自动给出一个默认的字段类型，对应表如下

<table>
    <tbody><tr>
    <td>go type's kind
    </td>
    <td>value method</td>
    <td>xorm type
    </td>
    </tr>
    <tr>
 <td>implemented Conversion</td>
 <td>Conversion.ToDB / Conversion.FromDB</td>
 <td>Text</td>
 </tr>
 <tr>
 <td>int, int8, int16, int32, uint, uint8, uint16, uint32</td>
 <td></td>
 <td> Int </td>
 </tr>
 <tr>
 <td>int64, uint64</td><td></td><td>BigInt</td>
 </tr>
 <tr><td>float32</td><td></td><td>Float</td>
 </tr>
 <tr><td>float64</td><td></td><td>Double</td>
 </tr>
 <tr><td>complex64, complex128</td>
 <td>json.Marshal / json.UnMarshal</td>
 <td>Varchar(64)</td>
 </tr>
 <tr>
 <td>[]uint8</td><td></td><td>Blob</td>
 </tr>
 <tr>
 <td>array, slice, map except []uint8</td>
 <td>json.Marshal / json.UnMarshal</td>
 <td>Text</td>
 </tr>
 <tr>
 <td>bool</td><td>1 or 0</td><td>Bool</td>
 </tr>
 <tr>
 <td>string</td><td></td><td>Varchar(255)</td>
 </tr>
 <tr>
 <td>time.Time</td><td></td><td>DateTime</td>
 </tr>
  <tr>
 <td>cascade struct</td><td>primary key field value</td><td>BigInt</td>
 </tr>
 <tr>
 </tr><tr>
 <td>struct</td><td>json.Marshal / json.UnMarshal</td><td>Text</td>
 </tr>
 <tr>
 <td>
 Others
 </td>
 <td></td>
 <td>
 Text
 </td>
 </tr>
 </tbody></table>
