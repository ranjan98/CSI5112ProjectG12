using aspnet.models;

namespace aspnet.services;
public class ProdService
{
    // Data placeholder
    private List<Product> prod = new List<Product>() {
        new Product("p1", "Tommy Red T-Shirt", "1","1","https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg","A red shirt - it is pretty red!", "29.99"),
        new Product("p2", "Trousers", "2","1","https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg","A nice pair of trousers.", "59.99"),
        new Product("p3", "Yellow Scarf", "2","1","https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg","Warm and cozy - exactly what you need for the winter.", "19.99"),
        new Product("p4", "Cast Iron Pan", "2","5","https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg","Prepare any meal you want.","49.99"),
        new Product("p5", "Huawei Matebook", "2","2","https://upload.wikimedia.org/wikipedia/commons/thumb/8/84/Huawei_Matebook_2-in-1_tablet_with_Windows_10_%2826627141971%29.jpg/580px-Huawei_Matebook_2-in-1_tablet_with_Windows_10_%2826627141971%29.jpg","Matebook is a 2-in-1 Laptop comes with a 256 GB SSD","1189.99"),
        new Product("p6", "Harry Potter Part 1", "2","3","https://upload.wikimedia.org/wikipedia/en/5/5c/Harry_Potter_and_the_Chamber_of_Secrets.jpg","Harry Potter and the Chamber of Secrets by J.K. Rowling - English","18.99"),
        new Product("p7", "Apple Watch Series 7", "2","4","data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBIUEhgVEhUZFRgaFRgcFBkYGBkcHRgaGhwcGRwaGBkcIS4lHB4rIRgYJjgmKy8xNTU1GiY7QDszPy40NTQBDAwMEA8QHhISHzQhJCQ0NzQ0NDQ0NDQ0NDQ0NjQ0NDQ0NDE0NTQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ/NDQ0NDQ0NP/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAEAAQUBAQAAAAAAAAAAAAAABwEDBAUGAgj/xABKEAACAQICBgYGBQoEBAcAAAABAgADEQQhBQYSMUFhByJRcYGREzJScqGxFEJigrIjM0NzkqLBwtHSFVOT4SQ0Y/AXVGR0g7Pi/8QAGAEBAAMBAAAAAAAAAAAAAAAAAAECAwT/xAAlEQEBAAIBBAICAgMAAAAAAAAAAQIRMRIhMkEDUSIzkaETcYH/2gAMAwEAAhEDEQA/AJmiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiabTuseGwa3rP1iLqi5u3cvAczYQNxLVeuiC7sqjtYgDzMiPTPSNiqpIoAUF4W6znvY5DwHjOTxGNq1G2qjs7drsWPmZeYVS5RN+J1uwCb66sfsBm+Ki3xmtq9IWDHqrUb7qgfFpDwJnoS3REdSVn6RqP1aLHvYD+Blv/AMR0/wDLn/U//EjFVM9MwUXY2k9EOqpPp9ItP61Bh3OD/KJnYfX7BtkwdOZUEfukn4SGH0ig3Zzx/iMdGJ1V9DYDTOGr/mqqsfZvZv2TY/CbCfNlPH9mXcZ1Wg9esVQsC3pk9hzc2+y+8fLlK3D6TMvtNMrNDoDWfDYwWRtl7Z02ybvX2hzHwm+mdmlyIiAiIgIiICIiAiIgIiICIiAlIkc9IGuno9rC4VuvurVFPqdqKfb7Tw3b90ybRbpka569rQLUMKQ1UXDvkVpnsHBm+A5m4EU16z1HL1GLsxuzMSST2kmWxPQm2OMjK5bAsuASgnoSyHoCe0WeFmZg8M9R0p0xtO7BVHM9vYBvJ4AGBlaJ0TXxLsmGXaZV2mJNlXfa7cCSLAfwBI5zSeHr06jU6ysrqc1YWt/tzn0Rq/oenhKC0kzO924u53sf4DgABwnIdL2EvhqdUKCVqbLNbMKwJAJ9m487TPr3dNOnUQwUY9glRQf2h5S5eNoyyqgw9TgQfhPamovrKe8ZwtQiXqeKtAv4TGlSGViCDdSCQVI4gjMGStqbrwKpWhi2Ac2CVNwc8Ffgrdh3Hkd8U2R94se0SguhzzHb2xcd8kun0vEjzUHW/b2cNiGu26jUY+v9hj7XYeO7fvkOY2arSXasREhJERAREQEREBERApE1emdNUsKgaoSWYkIi5s5HBR2DidwnEY/WfEVSdqoKCcERwptzqC7X7tnukzHaLdM7pA1y+jg4fDN+WYddx+iU8B9s/AZ9kiO87UPgwSWRGJJJYuSSTvJJTMy4MZgx9SmPEn+AmuPTPbO9V9OIEqJ23+I4Qf5f7J/ug6UwvbSH3D/fL7x+/wCkav04wGVDDtnY1NKYQLcmj4nY/umhxOMwlZWNO113gCx7+Y5yZ03iou5zGAk73ouwSvXq1mF/Rqqp71Ta2iOYVbffMjZamy3K8kvonxgFWvRY5sqOnPYLK3j1k8jKZ+KceUoTC0rgExFF6NQXV1se0cQw5ggEcxM2Jg2fNenNE1MLiHoVB1lOR4Mp9Vl5Ef04TXESaulPQtOrhDiMlejax9pWYKUPiQRzv2yGbTbG7jOzVW7Slp7tKSUKKxEzaVQEWO6YRE9U2sZMGbScq1r9x+REmTUTWj6Snoax/LIMif0ij63vDiPHttDDglbjeMxz7RMzRWOdHSpTbZdWDK3YR8xvBHEEyuWOyXT6NiarV7Sy4vDpWUWJydfZYZMO7iORE2sxakREBERAREQEsYrEJTptUqEKqKzOTuCgXJPgJfnEdLGPNLRrhd9V1TLfbNz4HYt96BDWsWsWIx2MbEMzIvWWggIBWmPq3OQyzZjlc+Wpq4/tcX+yrP5l2CnwFpd09gjQKoGuGQE55grvHu7RJt29wmlMte3ZWd+7OfEhrjaJ6jZlUSxFmFgu++zbxmWzkH1geYOHW/MX3TSGUjabG7Nc8GP+tQHyEwDjnBYqSoLEkCxF++2Zy3zDiLSSMz6exPWCN7yL+IAMPAzY6KCM4ZOrwZb3Kk7iD9ZTY79243uCdEJt9A01NQFr5MoWxAsXbY2jcZgEjLnIlpZEgaO0OtSne2e494mJQNXC4hXp5OjXW+48Cp5EEg8jOn1bzRuaI3ibqfwL5zVaxIA21Oyaywlc1/HLSY8HiFqU1ddzKCOV+B5jdMict0f4z0mEsfqsQO4gN8yZ1M48sdZWOnG7m0f9L2kdjCphwc61S7e5Tsx/eNP4yHl7J3vSvXLaQROCYdbd7M5PwC+U4WshBBA7/wDea4zUUy5eSJS09kSlpKHi0oVlyUIgXsO89UKbIxy6rFtg8CVsSBzG0uXMdoliibGZdPEnZNPeNtXU+yQrI1veul/1YhCSeirGkVK1EnJlWoo7CpCMfENT8pJcifotQnGO3AYdwe9np2/CfKSxMs+WmPCsREqsREQERECkjnpfa9PCp7VY/AoP5pI0jfpbHWwf6x/xUpMReHC4rR1Kq7NVXayVVuTkN+VuJL7+U4bSmEFKsyA3CtkeRAYX52MkJ/re+n8k4XWP/mqnev4VmvySaY/FbvTVGUnozzMW5ERACZ+iqgVzc2uF2ebB0YD92XdA6Er42utDDLtucydyoo3s7fVUf0AuTPFHDtSxDo4G1SNTaF7jbphuI3jaUSZyi8Jh0FUCg9mw/wC66/3TS1XGIO3UvssWKA3Cimu+o1jd7jcN3WWZGGZkwz59ZaFYeIamJosJiPyT/ZRFHrZLtXO/uWdWGWsZ/wBY5T8m/wBCazHBtakpNMsNtGa+0N193VNuzLtvJgwmJSrTSohurqGU9oIuJ84Va0mvo1rM2jKJbgagHcKjW/p4Tnyu+7WTXZxHSvhimOSp9WpQUA80Zgw8innOMWts3yvdHUj31K38CQe8CTP0j6G+kYIuou9G7r2lbddfLrd6CQmRL4XcVy7VZV8s4Ly5sCV9GJKqztcjKbXIy/6MSvoxAx1Y33TLwycTxlFQS6u4nlJ0JW6K9HlKFSuw/OsFT3adxcd7M4+6J3sw9F4NaFCnST1URVB7bDf3k5+MzJhbu7ayaisREhJERAREQKSN+lsgHCEmwFR7k8OtTkkSN+l2mGGFVtxdge4tTBiIvDkGFy1s+uvyQ/KcJrF/zVTvX8Kzp9MVPo9MvhwEs4V12eqcssuBGWY8b5TisRVZ2ZnN2Ykse0ma/JfTL4p7eK9F0bZdWVrA2YFTYi4NjwIIPjLMlTA4nD6eoLh8SVoaRppahWtYYhVF9lgOPEgbs2XLaWRxpTRtbDVno10KOhsVPwIPEHeCN8ybMKbjVnV/EY+uKOHW53ux9VF4sx4DlvO4T3qtq1iNIVxRoLlkajn1aa+0x+Q3mdnrLrJh9HUDo3RLdbdisSD1mbcVRhx3i4yUZDO5gV1g1gw+iqDaO0U16pyxmKFtraGRVCNzDMZZJmBdiWEfaNF3YXAJpuLsQBcqd5OQmCJn6KttM1gSqMwuAQCCADY5HfJnKLwlrRtEVabqDcNTr25gvTnFYNWRmpMCcijgXv8AZe3HcDlzne6vgBiBkAlYDl16c5rWfCKam3uYHIjI+c6sJ+Ev+2GV/LTR0NE4irVWlTXbZjZdnjz5DtJ3cZ9Dav6LGFwtKgDfYQBj2sc2PixJnFdE17VtpixsmbEk724nukkTnzkl1GuO7N15YAixznz7rNoz6NiqtEeqrHZ9xusnf1SB3ifQkijpbwgXEUqo+vTKnvptf5OPKML3Mp2R7ErE2UJWIgBLoHV75bEuncPehD6H0ZV2qFJvapofNQZlzV6tNfBYY/8Ap6X4Fm0nNW5ERAREQERECkjjpZaxwl/8xvxU5I8jXpdUMcIpFwajgjtBamCJMReEea1JbDtzqqfhb+E4hp2OsdMJhnVRYemWw8B/vOOaWz5U+LhWnUZWDISrKQVZSQVINwQRmCDxndYjWT/FUoUsQoXF0SStfZJFZVG0UZVG0rEAkWBBYWsNq44Ey/gPzqe+vzEpeK2w8o6/F63/AEXBHR2AXYs7jEYkWDVzexKgZqu8Akk7KruuROHlJWFSZmj9suFS13GybkAWJBObZDdMOZeApBi179VCwt2gj+smIvCZdAm7E/ZrfjpzR60Le47b7pvdB+ufdr/jpzR6xoWY52AzNt/Gwvwvn5eI7Pj/AFufLydd0Ubqthbq0/htDzkjSPejDfVyA6lPd3uPPL4yQpzfL5NsOCR50u070aDdlRh5qD/LJDnAdLZ/4eiP+qfwn+srjynLhE5iDE3ZkREIellxt6d5nhZ7b107oE9apn/gMN+op/hE281GqgtgMN/7en8VBm3nPeW04ViIkJIiICIiBSRj0yMwGE2M2232ebbVK3xknSNel49fBfrH/FSiIvCLdbGrbCB9gIWNwlz1wOJO8WJtOWM6rWrKkoORNdyO7PPuzHnOUMvn5K/Hw8mX8B+eT31+Ylgy/gPzye+vzEpfbXDyY0rKCVhUmw0T6zdUsuwdsAgNsllHVvle5X4zXzZ6E31P1Y/+ynJnKLwlzV5iTcixKViR2XenlNZpzc/ev8022g/XPu1/x05qdO7n95f5p2fH+v8Alz5eTrOi/fU/V0/xPJBke9F/6X9XS/FUkhTl+XybYcEjbpeq5YZedRj4bAHzMkmRL0s1r4umvs0AfFnb+0SMPJOXDgrToqWrLrTD1rqSLhBvHvHt5TJ6PdEDEYou1tmkgcX4uTZPKzHvUTudPYBhTY23DeJfLL1EY4+3DUNVPTITSYq9uqGzVuV9475y9RGVirAqykhgd4INiD4yadFYZaNMbXrWzHZ3yONfaQXHOwFvSIjnvN1P4L+MY5W3RlHPLPT/AJzuUSlPfPdNC9QqN5IUd5yHzmij6B0FT2MLQX2aFMeSATPnimgAAG4AAeE9zmbEREBERAREQEjHpjS5wd93pHB8Wpf0knSN+mdCMLQqWvsV7ealv5IRUWa2napqxAutZlB5WJt8BOSM6vWTEU6lIik2311diMwg2djM8CSRlv39k5Qy2fKvx8KGX9H/AJ5PfX5iY5mRo/8APJ76/MSt9tcPJjSsoJWFSbXQSks4Av1Bu/WU7zVTYaDv9JpbJIPpFzHZcbXha8n2i8Ji0GOuT9mt+NJp9YHHXHG6m3LrTcavuNksfYv+2xP8k5vWOqPSX7Cd3EG1x8B5Tsw/XHPl5O66LhlVP2KXzqSQZwvRhTHoqrgFQzqACbkbIOV7C/rDgJ3U5fk8q2w4VkN9KX/P/wDwpbzaTJIn6WsKRiaVTg9Ir4oxJ+FQSMOU5cMLo7RnesimxsjHuG0P4/GdXpnFCioRGJckAm5yF87CRjoTSr4astVM8irr7SHePgCOYE6LFaZpVWDBwB2MbEd4MtlO+zG9kiYHFU2A21GfEADzkVa8Y1K2OqFM0SyKRx2B1j+0Wmy0prYq0/R4c3cixfgg+z2tz3CcaJOOPtXK+l2lvmz1Sw/pMZQXtroT3K22fgpmnd7LlvOQnadGGD2sarEZU6btfmbUwPJ28pbK9kRMcREwakREBERAREQE5zXrRDYvR9akgu+xtUxxLodoKPesV+9OjiB8q6N0tSpItMpcMzemJzupFlsOQOY5c5j6S0K6den+UpnNWXOwPtW+e75SRuknUAJVfF0QfROS1YKL+iY722f8s7yR6pvwOXHYHAYil+YrKyn6psQfC+XhaW3ud1Nau45jDYd6jhEF2O4eF+PIGZdbQ+IRlBXrOTsWZTcrYnMHLfOpajimdXNJCV2r7II2gwtYnMj4xRwTowZcGqsNxFRha4t7Ean2by9RzJ0Bih+iP7S/1mHTwVVs1ps2dslJzG8ZDfOzpYAqQwwzKQQRas9rjluninhK5Uh6dQdd2Ho6hUWZtqzZZ2JOcnU+0dWX05XB6Mq1L2AUKbMzEKFP2r5zfYPCU0NJqR6ysyhyPzwIIZlG8BSbA/OesVoqoabLSw5XaKszNUJJKkncRYHM534zEwNHEs5Z73C7IJtkBwQDK3MRJ6ncu+b2jtk0kqU2F+wDuUW+ZbznPVsR6SpmcryzVwlS2e6dBqPoAYrFKjC6KNuse1Qckv8AaJA7tqdFvTjJ9KSdV2lnUzA+hwaC1i3XP3rbP7oWb6AInLbu7bSamiRh0t6QXaoUMrgNUbtF+qvhk/kJJrEAXOU+ftZdKfS8XVrXurNan+rXqr3XAv3sZOE3UZXs1jCeZbZmXmPjPH0gdh8pttmyBBcAXMxvTk+qp8YWmSbsb8o2aZFEbR2j90SWuivA7NKrWI9d1RfdQXJH3nI+7Itw6brC/IcT2CT7q7o/6PhaVHiqDb5sesx/aJlM7qLY8tpERMmhERAREQEREBERApOO0v0fYSsS9Law7nM+jtsE86bZD7uzOylIls4RZKgLWHReJwNXYqqrqc6dQLZXUcRvsRldeHMWJ1y6TPsLJ60/oaljKBo1Rkc1Yb0YbmXn8xccZAunNEVcJWajWFiPVI3OvBlPEH4ZjeJtjntnljp6/wAUb2bdxIlRpRuxv22/rNaDKgy+1dNidIg70v3m/wA5cGk+xPiJrAZ6Bky2GoyquKdznYDsEkfojRQMSfrXpX92z2+O15SMUM7Po80stDF7LGy1lCE8A4N0J8Sy/fEpnuxOHapjiJh6Sx9PD0mq1Tsogue09gA4kmwA5zBs5bpK056DC+hQ/lK4K5b1T67eIOyO89kh2bHT2lnxeIes+ROSrwVB6qju+JJPGa2bYzUZZXdJkYLRz13KUwLKpZ3YhURBvd3OSr/2LmY8rtmxFzY2JFzY23Ejja585KHnZA3G/PPPnnnKoLmeZk4ekSQACSSAABcknIADiSZYdT0f6I9Pi1ZhdKVnb3r9Rf2htdyGTPNBqhoT6HhVRrekbrVSPaI9UHsAsPAnjN/OfK7rTGaisREhYiIgIiICIiAiIgIiICaPWbV6jjaWxU6rC5puB1kP8VOV148jYjeRA+b9OaGrYOqaVZbEZqR6rrwZDxHy3Ga8NPovTmhKGLpejrpcb1YZMh7VPD5HjId1n1IxODJcA1aXB0G4f9Rfq9+7nwmuOW2dx05gGewZZzE9BpZVfUy/TeYgaXEeWEtap67UzRK4yoEamlw7fpFGXi4yy3neL524nXDWl8bUsLpRU/k14k7ttrb2t5DLtJ0aODkZ4egd658pXoku09V1paJlLxu3gzwSSYQq+e+OQlVQmZFOlb/vMyw8U6ckzo61XI2cXXW3+Qh5/pCPw+fYZa1Q1HYla+MTZUWKUWGbdhqDgPs7zx7DJsyyy9RfHH3VYiJmuREQEREBERAREQEREBERAREQEREDltM6j4LEXOx6Jz9anZbnmvqnyvznF6R6LsQtzQqJUHANdD5Zj4yXIkzKxGogHF6m4+l62Hc80G2PNLzU1sFVQ2dGU9jAj5z6UlJbrqvS+alRuyXU2p9E1MFSb1qaN3qp+Ylr/CML/kUv9NP6Ses6Xz/duImRhsBVqG1Ok7n7Cs3yEnyngKK+rSRe5FHyEyAI/wAh0If0ZqDjapBcLQXiWN2tyRf4kTvtAan4XCEMF9JUH6R7Ej3BuX5850cStytTMZFYiJVYiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiBSJWICIiAiIgIiICIiAiIgIiIH//Z","Apple Watch Series 7 Buy Now","399.99"),
        new Product("p8", "Apple Charger", "3","4","data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAkGBxEREhAQERIQEBAQDQ8SDxAPEBAQEBAQFREWFhYVExMYHSggGB0lGxYVITEhJSkrLi4uFx8zODMtNygvLisBCgoKDg0NDw0PDysZFRk3Ky0rKzcrKys3NzcrKysrKysrLSstKysrLSsrKysrKysrKysrKysrKysrKysrLSsrK//AABEIAOEA4QMBIgACEQEDEQH/xAAbAAEAAwEBAQEAAAAAAAAAAAAAAwQFAgEGB//EADsQAAIBAQQGCAQGAQQDAAAAAAABAgMEESExBRJBUWFxIjJSgZGhsdFCksHwExQVYnKCBpOy4vEWM0P/xAAVAQEBAAAAAAAAAAAAAAAAAAAAAf/EABYRAQEBAAAAAAAAAAAAAAAAAAARAf/aAAwDAQACEQMRAD8A/cQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQ1LRFbSjX0tFZAah45LejI/M1ZY4Qjvln3Iila4p6t8py3K9v5UWJW06sd55+NHf6mM6lV9mmv3O+Xyr3RxNxWM6su7VgvO8QradpjvPPzUd/ofPu32dfFF86t/1O46QpPL8N8neBvq0R3nSqreYX5yPZXgzqNtp8v7NeohW6memRCt2Z/MvqiT89KPXi7u0ulHxzXeIVpgq0LdGWTXcWYyTyIr0AAAAAAAAAAAAAAAAApWu1pL7xAnrWhR+8DMr29yd0U5Ph94HdKyTqYzvjHdtfsXo04U1gkvVlRlqwVJYzlqrdmyOcaVJ4LWnsv6Ur+BYt9rawWMnktiM+lCTbVNa03hKo+rHgvYDqtJvpVZ6sexGVz/tL6LxIY2yT6NClhvu1Y897NWy6EjfrVG6kuOS5LYalOlGOSSFI+XWi7VU609RbodHzz8zuH+KJ4yk5Pe3ez6gEVgR/xekj1/4zR3I3gB8//wCNQXVco/xk16HE9EVo5TU1unFPzWJ9GAPk50dXrwlTfbpt6vfd9UT0p1Y4warR3YRn3fC/I+jlBPNXmdadFLGVJ6kt3wvmi1Ip0J0ql9y1Jp9K6+Ek+K90Tpzg8Hrrc+jLu2MqVqSm9Wd9KtFdCpHP/lHgzqzWht/g1klUSvi11Zx7UH4XrNX8mw07Pb08HntTwaLsZJ5GPUoP+SXzLkz2haXF4vv294GwCOlVUuZIRQAAAAAAAAAjrzuXF4ICvbLRcnuXmyOx2W968/6rcc0aevPHqx82aRUChWq3tvYkWrTK6PPAzqmMZcZXfQYap06TqS4yze6OxI3LNZ4wSSV1xBo6lcr9rZdIoAAAAAAAAAAAAAr2yyRqLHNZNZpmPaLM6kXTk9WrB61Kp2ZbGuDya3No+gKVvpZTWaePICpom2a8U5LVkm4VY9mSdzXjintXMuWmxqWKwZm0o6toqJZVaUJ/3j0JPw1PA17HUvit6w8C6mMylUcHc+41aNXW5+pxa7MpriULNUcXqvNZAa4Oac71edEUAAAAACna548o+pcM+vi5c0XE1ZsdO6K44snOYLBcjoiq1teC5oo08ddbpP3NG1wvi9+wyfxLmp7JXRlwez28C4mtay9VciYrWSezvRZIoAAAAAAAAAAAAAEVpXRZKV7TPZ4gUHHpufZpavi736IsaLlenzKVsrfAs3m+G0vaLh0b9/oXUxeKVvs9/SWaLp40RVKx1suOD5l4zJQ1ZNbGX6E70t+0qJAARQAADPrdaXJM0CjbFdJPuYFyDwXI6IbNLC7cTADIt1HUbvV9OefBmucVaakmnimBh0LQ6bUZO+LfQnv4Pj6mzRrqX3gzJtdldO9Na9J993MrU3KGNN68ey30lyfxevMqPpQZFl0qnhk1mnmuaeKNCnaov7vJFTg5U09qOgAAAAHLmltQHQIKlqivu4oWvSqjtu3ceW1gaNaslz8kY9st13Rj0pv7v4LiVatpnP8AZHfLPuj7+B7Y7M5YQTSfWqSxcuW8qOrJQcpaucnjUlsS3I+hpQuSRFZLLGmrl3va2WCKAACpboZPcxZZYtb7mSNqSueQhSSd6vwQE4I41MbmSAAAAILXT1osnDAzrHWuz2YM0TLtdNwlrLvLVkrppLZs4cCotAAivGrzOtOi075QepLhk+aNIAfOWmhJYVKesllKON3Heu4gguxUa/bPpXejPqWitXsFOfWin3FqRixr1o7FJftlj4P3O46Sms4zX9b/APa2XJ6Fj8Mpx5SbXgyKWiaiyqeMV9BSIv1j+Xy1PYfrH8vlqex09G1u3D5X7j9NrduPyv3AjlpOTyjN/wBWv91xHK1VXlG7+UkvJXlpaIqPOo+6MV6ksNCR+KUpc5O7wFIyKk38VS79sFj9WSWezSf/AK6bvec6l978cWb9DR9OGUUu4sqKQpGVZtEbaj1nuyiu41IQSwR0CKAAAczyZ0eSyAr0CYhoEwED6yLRUqdZcy2gAAAAACOtT1lcZUoum+BskNooqSA5s1oTWfJ+5YMWUJQeHhvLtmtieHltRUXQeRknketkUBw6hz+Ny8QJQRqp93nSmgOgAAAAAAAAAAAAA8kenjApK0Qh1pJczr89S7cTA0vZb7RSU03TnOSavax1JNehP+h0Oy/mkBquvGTWrJO5rJl5HymirNq2itCN+pCULr23drU4u7xbPq4gegAAAAAAAirUVIza9lax81ma5443gY9O1Sjmm9l6+qL8pu6+WexbjmvZ4qUH+9ejPa0b7gIm28/A6jA6jEljEDmMSTUOlE6SAihUuai9vVfLYyYp2yV2pv8AxY3eJcAAAAAAAAAAAAAAMzTWj1WhdfKLTvUoScZJ3NYSWKwbML9Bkv8A62n/AF6j+p9geXAZOgdGqipXuc5SavlUk5yd2V7ZrgAAAAAAAAAAABV0l1HsucWnud+HmQ2a1qeEsJbV9UXK9PWi4vaj56tFwerP+ssr+T+gG/FEiRg0q811Z3rdL39kTfnqu6Hn7gbJHWrKKvbuX3kjHnbKr2wjxWPk19SnaKqWM5az45eHveBbq2vXnGXwqS1eLvz+/wDvdi7z5/RlmlUkqkk1FdVPN8WfQRQHoAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQ17PGaukk1xJgBiVtDXdSco8H0l7leWja+yUH/AFa+p9GLgPnI6JrPrVEl+2OPmy7ZNCwi9Z3ylvlj4bjWAHMIJHQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAB//2Q==","We Have a Wireless Charger Magnetic Fast","89.99"),
        new Product("p9", "Portable Heater", "3","5","https://m.media-amazon.com/images/I/81B6Aeux91L._AC_SL1500_.jpg","Portable Electric Heater with Thermostat and Heat Control","56.99"),
        new Product("p10", "Vitamin D Tablets", "3","6","data:image/jpeg;base64,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","Vitamin D Tablets for Daily Intake","29.99"),
    };

    public ProdService()
    {
    }

    public async Task createProd(Product newProd)
    {
        prod.Add(newProd);//changine in database
    }

    public async Task<List<Product>> getProd()
    {
        return prod;//getting it from database
    }

    public async Task<Product> getProd(string id)
    {
        return prod.Find(x => x.id == id);
    }
    // public async Task<Product> getmProd(string mid)
    // {
    //     return prod.Find(x => x.merchantid == mid);
    // }//getting all products of merchant

    public async Task<bool> updateProd(string Id, Product updatedProd)
    {
        bool result = false;
        int index = prod.FindIndex(x => x.id == Id);
        if (index != -1)
        {
            updatedProd.id = Id;
            prod[index] = updatedProd;
            result = true;
        }
        return result;
    }

    public async Task<bool> deleteProd(string Id)
    {
        bool deleted = false;
        int index = prod.FindIndex(x => x.id == Id);
        if (index != -1)
        {
            prod.RemoveAt(index);
            deleted = true;
        }
        return deleted;
    }
}