//
//  API+Extension.swift
//  Tests
//
//  Created by Patryk Maciąg on 17/02/2024.
//

@testable
import Recruitment_assignment
import Foundation

extension API {
    struct Character { }
    struct Location { }
    struct Episode { }
}

extension API.Character {
    struct JSON {
        static let valid: Data = """
        {
            "info": {
                "count": 2,
                "pages": 1,
                "next": null,
                "prev": null
            },
            "results": [
                {
                    "id": 17,
                    "name": "Annie",
                    "status": "Alive",
                    "species": "Human",
                    "type": "",
                    "gender": "Female",
                    "origin": {
                        "name": "Earth (C-137)",
                        "url": "https://rickandmortyapi.com/api/location/1"
                    },
                    "location": {
                        "name": "Anatomy Park",
                        "url": "https://rickandmortyapi.com/api/location/5"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/17.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/3"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/17",
                    "created": "2017-11-04T22:21:24.481Z"
                },
                {
                    "id": 416,
                    "name": "Muscular Mannie",
                    "status": "Alive",
                    "species": "Human",
                    "type": "Mannie",
                    "gender": "Male",
                    "origin": {
                        "name": "Interdimensional Cable",
                        "url": "https://rickandmortyapi.com/api/location/6"
                    },
                    "location": {
                        "name": "Interdimensional Cable",
                        "url": "https://rickandmortyapi.com/api/location/6"
                    },
                    "image": "https://rickandmortyapi.com/api/character/avatar/416.jpeg",
                    "episode": [
                        "https://rickandmortyapi.com/api/episode/8"
                    ],
                    "url": "https://rickandmortyapi.com/api/character/416",
                    "created": "2018-04-15T21:39:22.608Z"
                }
            ]
        }
        """.data(using: .utf8).unsafelyUnwrapped
        
        static let error: Data = """
            {
                "error": "There is nothing here"
            }
        """.data(using: .utf8).unsafelyUnwrapped
    }
}

extension API.Character {
    struct Mock {
        static let valid: API.Response<Character> = try! JSON.valid.decode(to: API.Response.self)
        static let error: API.Error = try! JSON.error.decode(to: API.Error.self)
    }
}

extension API.Location {
    struct JSON {
        static let valid: Data = """
        {
            "info": {
                "count": 3,
                "pages": 1,
                "next": null,
                "prev": null
            },
            "results": [
                {
                    "id": 77,
                    "name": "Earth (Fascist Dimension)",
                    "type": "Planet",
                    "dimension": "Fascist Dimension",
                    "residents": [
                        "https://rickandmortyapi.com/api/character/242",
                        "https://rickandmortyapi.com/api/character/498",
                        "https://rickandmortyapi.com/api/character/499",
                        "https://rickandmortyapi.com/api/character/500",
                        "https://rickandmortyapi.com/api/character/501",
                        "https://rickandmortyapi.com/api/character/502"
                    ],
                    "url": "https://rickandmortyapi.com/api/location/77",
                    "created": "2020-05-02T09:39:49.158Z"
                },
                {
                    "id": 80,
                    "name": "Earth (Fascist Shrimp Dimension)",
                    "type": "Planet",
                    "dimension": "Fascist Shrimp Dimension",
                    "residents": [
                        "https://rickandmortyapi.com/api/character/503",
                        "https://rickandmortyapi.com/api/character/504",
                        "https://rickandmortyapi.com/api/character/505",
                        "https://rickandmortyapi.com/api/character/506"
                    ],
                    "url": "https://rickandmortyapi.com/api/location/80",
                    "created": "2020-05-02T11:52:35.156Z"
                },
                {
                    "id": 81,
                    "name": "Earth (Fascist Teddy Bear Dimension)",
                    "type": "Planet",
                    "dimension": "Fascist Teddy Bear Dimension",
                    "residents": [
                        "https://rickandmortyapi.com/api/character/507",
                        "https://rickandmortyapi.com/api/character/508"
                    ],
                    "url": "https://rickandmortyapi.com/api/location/81",
                    "created": "2020-05-02T12:16:18.224Z"
                }
            ]
        }
        """.data(using: .utf8).unsafelyUnwrapped
    }
}

extension API.Location {
    struct Mock {
        static let valid: API.Response<Location> = try! JSON.valid.decode(to: API.Response.self)
    }
}

extension API.Episode {
    struct JSON {
        static let valid: Data = """
        {
            "info": {
                "count": 2,
                "pages": 1,
                "next": null,
                "prev": null
            },
            "results": [
                {
                    "id": 23,
                    "name": "Rickmancing the Stone",
                    "air_date": "July 30, 2017",
                    "episode": "S03E02",
                    "characters": [
                        "https://rickandmortyapi.com/api/character/1",
                        "https://rickandmortyapi.com/api/character/2",
                        "https://rickandmortyapi.com/api/character/3",
                        "https://rickandmortyapi.com/api/character/4",
                        "https://rickandmortyapi.com/api/character/5",
                        "https://rickandmortyapi.com/api/character/323",
                        "https://rickandmortyapi.com/api/character/342"
                    ],
                    "url": "https://rickandmortyapi.com/api/episode/23",
                    "created": "2017-11-10T12:56:36.100Z"
                },
                {
                    "id": 33,
                    "name": "The Old Man and the Seat",
                    "air_date": "November 17, 2019",
                    "episode": "S04E02",
                    "characters": [
                        "https://rickandmortyapi.com/api/character/1",
                        "https://rickandmortyapi.com/api/character/2",
                        "https://rickandmortyapi.com/api/character/3",
                        "https://rickandmortyapi.com/api/character/4",
                        "https://rickandmortyapi.com/api/character/5"
                    ],
                    "url": "https://rickandmortyapi.com/api/episode/33",
                    "created": "2020-04-30T06:52:04.498Z"
                }
            ]
        }
        """.data(using: .utf8).unsafelyUnwrapped
    }
}

extension API.Episode {
    struct Mock {
        static let valid: API.Response<Episode> = try! JSON.valid.decode(to: API.Response.self)
    }
}
