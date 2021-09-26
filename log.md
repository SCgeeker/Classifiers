## 準備紀錄

### 第一階段 分類詞~物件名詞契合度調查

#### 整理素材

- 分類詞來源：(stimuli_process.R)
1. 田意民等人(2002)九項分類詞
2. 何萬順等(2011,2020)61項分類詞，其中26項表徵物件形狀

- 物件名詞來源：
1. 田意民等人(2002)選用的124項名詞(stimuli_process.R)
2. 平衡語料庫查詢何萬順等(2011,2020)26項表徵物件形狀項分類詞(Nf)，跟隨Nf的實體物件名詞Na(read_items.R)
2-1. 使用進階查詢，設定過濾條件**包含**  範圍起：1 範圍迄： * 詞類=Na 可得分類詞(Nf)+實體名詞(Na)的結果。

e.g., "個(Nf)"共有10830條Nf+Na的結果

2-2. 總計查到的分類詞之實體名詞個數(Type frequency)及總次數(token freqency) (summar_items.R)
terms_summary.csv



- THT分類詞與物件名詞調查:
1. 四項實驗一共選用120個實體物件名詞。
2. 計算所有形狀類分分類詞搭配的實體名詞個數(THT_checking.R -> THT_nouns_check.csv)

3. THT有研究的分類詞
tiao(條)   9     
zhi(枝)   12     
gen(根)   25     
zhang(張) 15    
mian(面)   6    
pian(片)  11    
ge(個)    18    
ke(顆)    11     
li(粒)     6

4. THT未研究的分類詞 
dian(點)   2      
jie(節)    1  1D  
ban(瓣)    1  2D   
duo(朵)    3  2D    
feng(封)   0  2D
fu(幅)     4  2D
ye(葉)     0  2D
zheng(幀)  0  2D  
ding(頂)   0  3D   
mei(枚)    2  3D
ju(具)     1  3D
juan(卷)   2  3D 
kuai(塊)   8  3D 
zun(座)    0  3D

5. THT研究一的物件名詞有8個無平衡語料庫4.0之資料。


#### 調查項目準備

- 調查問卷發佈平台
https://www.tatoh.com.tw/

