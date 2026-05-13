#title[Demo]

= Typography

Tailwind Typography and Typst helps styling `inline code`, coloured inline code:
```rust fn foo<T: Clone>(f: fn(T) -> ())```, *bold*, _italics_, *_bold italics_*, #highlight[highlighted text],
#underline[underlined text], #overline[overlined text], "quoted text", "quote's 'effect' in quoted text",
#smallcaps[SmallCaps], #strike[strikethrough text], #sub[subscripts], #super[superscripts], #upper[uppercase text],
#highlight(underline(
  overline[*And* a #sub(
      smallcaps(strike["_comprehensive_"]),
    ) #super(upper[*_example_*])],
))

#lorem(100)

#for i in range(4) {
  heading(level: i + 1, [Heading #(i + 1)], outlined: false)
}

Note that these headings are not outlined, so they would not appear on the sidebar.

Framed text:

#html.frame[#lorem(10)]

= Math

Inline: the root formula is $x = (-b plus.minus sqrt(b^2 - 4 a c))/(2a)$ and the Chudnovsky algorithm is
$1/pi = sqrt(10005)/4270934400 sum^oo_(k=0) ((-1)^k(6k)!(545140134k + 13591409))/((3k)!(k!)^3(640320)^(3k))$ with
#lorem(30)

#link(
  "https://en.wikipedia.org/wiki/Chudnovsky_algorithm",
  figure(
    caption: [Click on the formula!],
    $
      1/pi = sqrt(10005)/4270934400 sum^oo_(k=0) ((-1)^k(6k)!(545140134k + 13591409))/((3k)!(k!)^3(640320)^(3k))
    $,
  ),
)

= Lists

Unordered list:

- Foo
- Bar
- Baz
  - Fizz
  - Buzz

Numbered list:

+ Foo
+ Bar
+ Baz
  + Fizz
  + Buzz

= Prime Number Table

#let is-prime(n) = {
  if n <= 1 {
    return false
  }
  if n == 2 {
    return true
  }
  if calc.rem(n, 2) == 0 {
    return false
  }

  let limit = int(calc.sqrt(n)) + 1
  for i in range(3, limit, step: 2) {
    if calc.rem(n, i) == 0 { return false }
  }
  return true
}

#table(
  columns: (2em,) * 10,
  rows: (2em,) * 10,
  ..range(100)
    .map(it => it + 1)
    .map(n => if is-prime(n) { table.cell(fill: yellow, highlight(fill: yellow)[#n]) } else { [#n] })
)

= CJK

日本利用壓電瓷磚將腳步轉化為電能。這些瓷磚捕捉來自你腳步的動能。當你行走時，你的重量和動作會對瓷磚產生壓力。瓷磚會輕微彎曲，從而產生機械應力。瓷磚內部的壓電材料將這種應力轉化為電能。每一步都會產生少量電荷，而數百萬步結合在一起就能產生足夠的電力來驅動
LED 燈、數字顯示屏和傳感器。 在像澀谷車站這樣繁忙的地方，每天大約有 240
萬個腳步為這一系統作出貢獻。這些電能可以被儲存或立即使用，從而減少對傳統電力來源的依賴，並支持可持續的城市基礎設施。這種方法將日常運動轉化為實用的可再生能源。

= CJK Vertical Layout

#context if target() == "html" {
  [Please note that Typst itself doesn't yet support vertical layout. The following is done by using the
    `writing-mode: vertical-rl` CSS property.]
  html.div(
    class: "[writing-mode:vertical-rl] max-h-[70vh] w-full overflow-x-auto prose-p:mt-0 prose-p:mb-0 prose-p:ml-2",
  )[
    #set heading(outlined: false)

    #link(
      "https://zh.wikisource.org/zh/中華民國臨時約法",
    )[= 中華民國臨時約法]

    == 第一章　總綱

    第一條　中華民國由中華人民組織之。

    第二條　中華民國之主權屬於國民全體。

    第三條　中華民國領土，爲二十二行省、內外蒙古、西藏、靑海。

    第四條　中華民國以參議院、臨時大總統、國務院、法院行使其統治權。

    == 第二章　人民

    第五條　中華民國人民一律平等，無種族、階級、宗教之區別。

    第六條　人民得享有左列各項之自由權：\
    　一、人民之身體，非依法律不得逮捕、拘禁、審問、處罰。\
    　二、人民之家宅，非依法律不得侵入或搜索。\
    　三、人民有保有財產及營業之自由。\
    　四、人民有言論、著作、刊行及集會結社之自由。\
    　五、人民有書信秘密之自由。\
    　六、人民有居住遷徙之自由。\
    　七、人民有信敎之自由。

    第七條　人民有請願於議會之權。

    第八條　人民有陳訴於行政官署之權。

    第九條　人民有訴訟於法院受其審判之權。

    第十條　人民對於官吏違法損害權利之行爲，有陳訴於平政院之權。

    第十一條　人民有應任官考試之權。

    第十二條　人民有選舉及被選舉之權。

    第十三條　人民依法律有納稅之義務。

    第十四條　人民依法律有服兵之義務。

    第十五條　本章所載人民之權利，有認爲增進公益、維持治安或非常緊急必要時，得依法律限制之。

    == 第三章　參議院

    第十六條　中華民國之立法權，以參議院行之。

    第十七條　參議院以第十八條所定各地方選派之參議員組織之。

    第十八條　參議員每行省、內蒙古、外蒙古、西藏各選派五人，靑海選派一人。其選派方法，由各地方自定之。參議院會議時，每參議員有一表決權。

    第十九條　參議院之職權如左︰\
    　一、議決一切法律案。\
    　二、議決臨時政府之豫算、決算。\
    　三、議決全國之稅法、幣制及度量衡之準則。\
    　四、議決公債之募集及國庫有負擔之契約。\
    　五、承諾第三十四條、三十五條、四十條事件。\
    　六、答覆臨時政府諮詢事件。\
    　七、受理人民之請願。\
    　八、得以關於法律及其他事件之意見建議於政府。\
    　九、得提出質問書於國務員，並要求其出席答覆。\
    　十、得咨請臨時政府查辦官吏納賄違法事件。\
    　十一、參議院對於臨時大總統認爲有謀叛行爲時，得以總員五分四以上之出席，出席員四分三以上之可決，彈劾之。\
    　十二、參議院對於國務員認爲失職或違法時，得以總員四分三以上之出席，出席員三分二以上之可決，彈劾之。

    第二十條　參議院得自行集會、開會、閉會。

    第二十一條　參議院之會議，須公開之。但有國務員之要求，或出席參議員過半數之可決者，得秘密之。

    第二十二條　參議院議決事件，咨由臨時大總統公布施行。

    第二十三條　臨時大總統對於參議院議決事件，如否認時，得於咨達後十日內聲明理由，咨院覆議。但參議院對於覆議事件，如有到會參議員三分二以上仍執前議時，仍照第二十二條辦理。

    第二十四條　參議院議長，由參議員用記名投票法互選之，以得票滿投票總數之半者爲當選。

    第二十五條　參議院參議員於院內之言論及表決，對於院外不負責任。

    第二十六條　參議院參議員除現行犯及關於內亂、外患之犯罪外，會期中非得本院許可，不得逮捕。

    第二十七條　參議院法，由參議院自定之。

    第二十八條　參議院以國會成立之日解散，其職權由國會行之。

    （下略）
  ]
} else [
  Unfortunately Paged target doesn't support vertical layout yet.
]

= Code

The source code of this example:

#raw(block: true, lang: "typ", read("./demo.typ"))
